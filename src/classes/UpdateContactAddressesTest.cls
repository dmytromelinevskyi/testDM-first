/**
 * Created by dmeli on 26.09.19.
 */

@isTest
private class UpdateContactAddressesTest {
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        // insert 10 accounts
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Lead ' + i, LeadSource = 'Dreamforce'));
        }
        insert leads;
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }

}