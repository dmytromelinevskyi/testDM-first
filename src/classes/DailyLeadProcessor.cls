/**
 * Created by dmeli on 27.09.19.
 */

global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [
                SELECT Id, FirstName, LastName, LeadSource
                FROM Lead
                WHERE LeadSource = NULL
                LIMIT 200
        ];
        List<Lead> leadToUpdate = new List<Lead>();

        if (!leads.isEmpty()) {
            for (Lead lead : leads) {
                lead.LeadSource = 'Dreamforce';
                leadToUpdate.add(lead);
            }
        }

        update leadToUpdate;

//        TaskUtils.dailyLeadProcessor(leads);
    }
}