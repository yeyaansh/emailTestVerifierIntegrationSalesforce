trigger ContactEmailPatternTrigger on Contact (after insert, after update) {

    if(Trigger.isAfter)
    {
        // when new contacts are inserted, generate email patterns
        if(Trigger.isInsert)
        {
            System.debug('At Line Trigger No. Line 8');

            Set<Id> accountIdSet = new Set<Id>();

            // Get all contacts having accountId
            for(Contact contactInvolvedSingle : Trigger.new)
            {
                System.debug('At Line Trigger No. Line 15');
                if(String.isNotBlank(contactInvolvedSingle.AccountId))
                {
                    accountIdSet.add(contactInvolvedSingle.AccountId);
                }
            }

            // Query Account Details of these Contacts
            Map<Id, Account> accountDetailsMap = new Map<Id, Account>([SELECT Id, Name, Company_Domain__c from Account where Id in: accountIdSet]);

            // Store all the Email Patterns to be Created
            List<Email_Patterns__c> emailPatternList = new List<Email_Patterns__c>();

            for(Contact singleContact : Trigger.new)
            {

                // Check if Contact's Parent Account Exists or not!
                if(String.isNotBlank(singleContact.AccountId))
                {
                    // Get the Company Domain from Account (using AccountId)
                    Account parentAccount = accountDetailsMap.get(singleContact.AccountId);

                    // If no parent don't perform anything
                    if(parentAccount == null)
                    {
                        System.debug('No Parent Account Exists! for Contact: '+ singleContact.LastName );
                        return;
                    }

                    // Check if Company Domain is Present or not, because email patterns will be generated using this Company Domain.
                    if(String.isBlank(parentAccount.Company_Domain__c))
                    {
                        System.debug('Company Domain is not available for Contact: '+ singleContact.LastName + ' having parent: '+parentAccount.Name);
                        return;
                    }


                    // Case: 1 Both firstName and lastName is present
                    if(String.isNotBlank(singleContact.FirstName) && String.isNotBlank(singleContact.LastName))
                    {
                        // Create the logic which will create the Email Pattern logic
                        List<Email_Patterns__c> generatedEmailPatterns = ContactEmailPatternTriggerHelper.generateEmailPatterns(singleContact.FirstName, singleContact.LastName, parentAccount.Company_Domain__c, singleContact.Id);

                        // Add the Email_Patterns__c details in emailPatternList after populating the Contact Id in it.
                        emailPatternList.addAll(generatedEmailPatterns); 

                    }
        
                    // Case: 2 When Only Last Name is present
                    

                }
            }

            insert emailPatternList;
            
        }

        // when existing contacts are updated
        else if(Trigger.isUpdate)
        {
            // if this contact have no email patterns before, so generate them

            // if this contact had email patterns before (just update them, the existing ones)

            // focus on this part first for your MVP // when user clicks the Send Email Checkbox, verify the emails
            Set<Id> contactsIdSet = new Set<Id>();
            
            // Trigger this one when Send Email [] button is checked on Contact Record

            Map<Id, Contact> newContactsInvolved = Trigger.newMap;
            Map<Id, Contact> oldContactsInvolved = Trigger.oldMap;



            for(Contact new_single_Contact : newContactsInvolved.values())
            {

                System.debug('At Line Trigger No. Line 93');

                if(oldContactsInvolved.containsKey(new_single_Contact.Id))
                {
                    Contact temp_prior_Contact  = oldContactsInvolved.get(new_single_Contact.Id);
                    
                    if(temp_prior_Contact.Verify_Emails__c == false && new_single_Contact.Verify_Emails__c == true)
                    {
                        System.debug('At Line Trigger No. Line 101');
                        contactsIdSet.add(new_single_Contact.Id);
                    }
                    
                }
            }
            
            // gather all emaiPattern records associated with this contact and whose status is not 'valid'

            ContactEmailPatternBatch batchApex = new ContactEmailPatternBatch(contactsIdSet);
            Database.executeBatch(batchApex, 1);

            // send these emails from your salesforce org to EmailTestVerify and get the status of it (along with the response).

            // now update these emailPattern records
        }
    }

}


// Questions: How will you handle contacts having only lastName (because a contact won't be created if it has no last name) -> in this case you could use patterns like lastName@companyDomain.com, lastName.lastName@xyz.com, f_lastName+lastName@xyz.com, f_lastName.lastName@xyz.com