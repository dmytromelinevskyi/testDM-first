public class ContactSearch {
    
    public static List<Contact> searchForContacts(String name, String postal_code) {
        List<Contact> contacts = [SELECT Name FROM Contact WHERE (LastName =: name AND MailingPostalCode =: postal_code)];
        return contacts;
    }
}