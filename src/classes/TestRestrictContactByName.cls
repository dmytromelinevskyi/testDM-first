@isTest
public class TestRestrictContactByName {
    
    //@isTest static void RestrictContactByNameTest() {
       // Contact c = new Contact(LastName='INVALIDNAME');
        //insert c;
    //}
    
    
    @isTest static void RestrictContactByNameTest() {
        // Test data setup
        // Create one account with one opportunity by calling a utility method
        Contact[] cont = RandomContactFactory.generateRandomContacts(1,'INVALIDNAME');
        
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(cont[0], false);
        Test.stopTest();
        // Verify that the deletion should have been stopped by the trigger,
        // so check that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }
}