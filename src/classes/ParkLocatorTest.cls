/**
 * Created by dmeli on 05.11.19.
 */

@IsTest
private class ParkLocatorTest {
    @isTest static void testCallout() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        List <String> parkResults = ParkLocator.country('Germany');
        // Verify that a fake result is returned
        System.assert(new List<String>{'a', 'b'}==parkResults);
    }
}