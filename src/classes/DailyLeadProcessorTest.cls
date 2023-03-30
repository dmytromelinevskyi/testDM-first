/**
 * Created by dmeli on 27.09.19.
 */


@isTest
private class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 1 * * ?';

    @isTest static void testScheduledJob() {
        List<Lead> leads = new List<Lead>();

        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(
                    FirstName = 'Test Lead' + i, LastName = 'NY', LeadSource = '', Company = 'Company'
            ));
        }

        insert leads;

        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());

        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
                CRON_EXP,
                new DailyLeadProcessor());
        List<Task> lt = [
                SELECT Id
                FROM Task
                WHERE WhatId IN :leadIds
        ];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        Test.stopTest();

        lt = [
                SELECT Id
                FROM Task
                WHERE WhatId IN :leadIds
        ];
        System.assertEquals(0,
                lt.size(),
                'Tasks were not created CYKA');
    }
}