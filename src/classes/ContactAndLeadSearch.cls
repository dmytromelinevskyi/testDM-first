public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(String name){
        
        List<List<sObject>> searchList = [FIND :name IN NAME FIELDS 
                   RETURNING Contact(Name),Lead(LastName)];
        System.debug(searchList);
        return searchList;
    }
}