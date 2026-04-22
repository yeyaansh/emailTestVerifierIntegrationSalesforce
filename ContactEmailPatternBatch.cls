public with sharing class ContactEmailPatternBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {
    
    List<Id> contactsIdSet;
    
public ContactEmailPatternBatch(Set<Id> contactsIdSet)
{
    List<Id> setToID = new List<Id>(contactsIdSet);
    this.contactsIdSet = setToID;
}

    public Database.QueryLocator start(Database.BatchableContext BC) {
        // we will get the records from here
        List<String> excludeStatus = new List<String>();
        excludeStatus.add('Valid');
        String queryString = 'SELECT Id, Name, Status__c, Email_Address__c from Email_Patterns__c where Contact__c in: contactsIdSet and Status__c not in:excludeStatus';
        return Database.getQueryLocator(queryString);
            
    }

    public void execute(Database.BatchableContext BC, List<Email_Patterns__c> emailPatternLists) {
        // we will perform operation on these fetched records
        List<Email_Patterns__c> emailsPatternUpdateList = new List<Email_Patterns__c>();

        System.debug('At Line No. 24');

        for(Email_Patterns__c singleEmailPattern : emailPatternLists)
        {
            Email_Patterns__c tempEmailPattern = new Email_Patterns__c(Id = singleEmailPattern.Id);

            String encodedEmail = EncodingUtil.urlEncode(singleEmailPattern.Email_Address__c,'UTF-8');

            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setTimeout(10000);
            System.debug('At Line No. 36');
            System.debug('Endpoint URL is: ');
            System.debug('callout:Email_Test_Verify_Named_Credential/api/verifyEmail?email='+encodedEmail);
            req.setEndpoint('callout:Email_Test_Verify_Named_Credential/api/verifyEmail?email='+encodedEmail);
            System.debug('At Line No. 38');

            HttpResponse res = http.send(req);
            
            System.debug(res);
            System.debug('At Line No. 44');
            
            if(res.getStatusCode() == 200)
            {
                // System.debug(res.getHeaderKeys());
                if(res.getBody().toString() == 'ok')
                {
                    tempEmailPattern.API_Response__c = res.getBody().toString();
                    tempEmailPattern.Status__c = 'Valid';
                    tempEmailPattern.Is_Correct_Email__c = true;
                    tempEmailPattern.Verified_At__c = Datetime.now();
                    emailsPatternUpdateList.add(tempEmailPattern);
                }
                else {
                    System.debug(res.getBody().toString());
                    tempEmailPattern.API_Response__c = res.getBody().toString();
                    tempEmailPattern.Status__c = 'Valid';
                    tempEmailPattern.Is_Correct_Email__c = false;
                    tempEmailPattern.Verified_At__c = Datetime.now();
                    emailsPatternUpdateList.add(tempEmailPattern);
                }
            }
            else {
                System.debug(res.getBody().toString());
                tempEmailPattern.API_Response__c = res.getBody().toString() + '\n' + 'StatusCode: '+ res.getStatusCode();
                tempEmailPattern.Status__c = 'Failed';
                tempEmailPattern.Is_Correct_Email__c = false;
                tempEmailPattern.Verified_At__c = Datetime.now();
                emailsPatternUpdateList.add(tempEmailPattern);
            }
        }

        update emailsPatternUpdateList;

    }

    public void finish(Database.BatchableContext BC) {
        // Code
        // do nothing
    }
}


