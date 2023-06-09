/**
 * Created by dmeli on 05.11.19.
 */

@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the accountId from the end of the URL
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account objAccount = [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];
        return objAccount;
    }
}