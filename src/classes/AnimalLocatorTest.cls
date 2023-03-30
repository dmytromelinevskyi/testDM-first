/**
 * Created by dmeli on 04.11.19.
 */

@IsTest
private class AnimalLocatorTest{
    @IsTest static  void AnimalLocatorMock1() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result=AnimalLocator.getAnimalNameById(3);
        String expectedResult='chicken';
        System.assertEquals(result, expectedResult);
    }
}