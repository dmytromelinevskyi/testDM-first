/**
 * Created by dmeli on 26.09.19.
 */

@IsTest
public class AccountProcessorTest {
    @isTest static void TestAccountProcessorTest() {
        Account a = new Account();
        a.Name = 'Account Processor';
        insert a;

        Contact cont = new Contact();
        cont.FirstName = 'Test';
        cont.LastName = 'Test';
        cont.AccountId = a.Id;
        insert cont;

        List<Id> listToUpdate = new List<Id>();
        listToUpdate.add(a.Id);

        Test.startTest();
        AccountProcessor.countContacts(listToUpdate);
        Test.stopTest();

        Account ACC = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :a.Id LIMIT 1];
        System.assertEquals (Integer.valueOf(ACC.Number_of_Contacts__c), 1);
    }

}