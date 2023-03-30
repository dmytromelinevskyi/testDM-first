public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numCont, String LastContName) {
        List<Contact> cont = new List<Contact>();
        
        for(Integer i=0;i<numCont;i++) {
            Contact c = new Contact(LastName = LastContName, FirstName = 'Test ' + i);
            cont.add(c);
        }
        insert cont;
        
        return cont;
    }	
}