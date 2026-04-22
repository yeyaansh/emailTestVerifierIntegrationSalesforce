public class ContactEmailPatternTriggerHelper {
    
    public static List<Email_Patterns__c> generateEmailPatterns(String FirstName, String LastName, String CompanyDomain, Id parentContactId)
    {

        List<Email_Patterns__c> emailPatternsList = new List<Email_Patterns__c>();

        FirstName = FirstName.trim().toLowerCase();
        LastName = LastName.trim().toLowerCase();
        CompanyDomain = CompanyDomain.trim().toLowerCase();

        // First get the Picklist Values of patterns
        Schema.DescribeFieldResult fieldResult = Email_Patterns__c.Pattern__c.getDescribe();
        List<Schema.PicklistEntry> picklistResult = fieldResult.getPicklistValues();
        
        for(Schema.PicklistEntry singlePicklistValue : picklistResult)
        {
            Email_Patterns__c singleEmailGenerate = new Email_Patterns__c();

            if(singlePicklistValue.getValue() == 'first')
            {
                String finalEmail = FirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'last')
            {
                String finalEmail = LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'first.last')
            {
                String finalEmail = FirstName+'.'+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'last.first')
            {
                String finalEmail = LastName+'.'+FirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'f_initial + last')
            {
                String modifiedFirstName = FirstName.substring(0,1);
                String finalEmail = modifiedFirstName+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'l_initial + first')
            {
                String modifiedLastName = LastName.substring(0,1);
                String finalEmail = modifiedLastName+FirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'f_initial.last')
            {
                String modifiedFirstName = FirstName.substring(0,1);
                String finalEmail = modifiedFirstName+'.'+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'first.l_initial')
            {
                String modifiedLastName = LastName.substring(0,1);
                String finalEmail = FirstName+'.'+modifiedLastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'last.f_initial')
            {
                String modifiedFirstName = FirstName.substring(0,1);
                String finalEmail = LastName+'.'+modifiedFirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'firstlast')
            {
                String finalEmail = FirstName+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'lastfirst')
            {
                String finalEmail = LastName+FirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'first-last')
            {
                String finalEmail = FirstName+'-'+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'first_last')
            {
                String finalEmail = FirstName+'_'+LastName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
            else if(singlePicklistValue.getValue() == 'last_first')
            {
                String finalEmail = LastName+'_'+FirstName+'@'+CompanyDomain;

                singleEmailGenerate.Email_Address__c = finalEmail;
                singleEmailGenerate.Pattern__c = singlePicklistValue.getValue();
                singleEmailGenerate.Contact__c = parentContactId;
                emailPatternsList.add(singleEmailGenerate);
            }
        }
        return emailPatternsList;
    }
}