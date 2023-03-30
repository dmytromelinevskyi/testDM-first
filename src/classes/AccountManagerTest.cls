/**
 * Created by dmeli on 05.11.19.
 */

@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccount() {
        // Create test record
        Account accountTest = new Account(
                Name = 'Test'
        );
        insert accountTest;
        Contact contactTest = new Contact(
                FirstName = 'Test',
                LastName = 'Test'
        );
        contactTest.AccountId = accountTest.Id;
        insert contactTest;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
                'https://cunning-wolf-bqcmxl-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + accountTest.Id + '/contacts/';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assert('Test' == thisAccount.Name);
    }
}