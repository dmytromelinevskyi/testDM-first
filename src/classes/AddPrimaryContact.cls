/**
 * Created by dmeli on 27.09.19.
 */

public with sharing class AddPrimaryContact implements Queueable {

    private Contact contact;
    private String state;

    public addPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Contacts) FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : accounts) {
            Contact cont = contact.clone(false, false, false, false);
            cont.AccountId = acc.Id;
            contactsToInsert.add(cont);
        }

        insert contactsToInsert;
    }
}