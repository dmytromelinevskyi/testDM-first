/**
 * Created by dmeli on 26.09.19.
 */

public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountsIds) {
        List<Account> listToUpdate = new List<Account>();
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts), Number_of_Contacts__c FROM Account WHERE Id IN :accountsIds];
        for (Account accId : accounts) {
            List<Contact> contacts = accId.Contacts;
            accId.Number_of_Contacts__c = contacts.size();
            listToUpdate.add(accId);
        }
        update listToUpdate;
    }
}