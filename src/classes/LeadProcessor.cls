/**
 * Created by dmeli on 26.09.19.
 */

global class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                'SELECT Id, FirstName, LeadSource FROM Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        // process each batch of records
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : scope) {
            if (lead.LeadSource == 'Dreamforce') {
                leadsToUpdate.add(lead);
            }
            recordsProcessed = recordsProcessed + 1;
        }
        update leadsToUpdate;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [
                SELECT Id, Status, NumberOfErrors,
                        JobItemsProcessed,
                        TotalJobItems, CreatedBy.Email
                FROM AsyncApexJob
                WHERE Id = :bc.getJobId()
        ];
    }
}