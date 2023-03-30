@isTest
public class TestVerifyDate {
	
    @isTest static void testCheckDates() {
        Date day1 = system.today();
        Date day2 = system.today()+20;
        
        Date dateCheck = VerifyDate.CheckDates(day1, day2);
        System.assertEquals(day2, dateCheck);
    }
    
    @isTest static void testCheckDates1()
    {
        Date day1 = system.today();
        Date day2 = system.today()-20;
        
        Date dateCheck = VerifyDate.CheckDates(day1, day2);
        System.assertEquals(day2, dateCheck);
    }
     @isTest static void testCheckDates2()
    {
        Date day1 = system.today();
        Date day2 = system.today()+60;
        
        Date dateCheck = VerifyDate.CheckDates(day1, day2);
        System.assertEquals(day2, dateCheck);
    }
}