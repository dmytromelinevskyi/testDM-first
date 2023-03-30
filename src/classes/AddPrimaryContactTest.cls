/**
 * Created by dmeli on 27.09.19.
 */

@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add 100 child accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                    Name = 'Test Account' + i, BillingState = 'NY'
            ));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                    Name = 'Test Account CA' + i, BillingState = 'CA'
            ));
        }
        insert accounts;
    }

    @isTest static void testQueueable() {
        String state = 'CA';
        Contact contact = new Contact(FirstName = 'Test', LastName = 'Last Test');

        addPrimaryContact updater = new addPrimaryContact(contact, state);
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE BillingState = :state)]);
    }

}