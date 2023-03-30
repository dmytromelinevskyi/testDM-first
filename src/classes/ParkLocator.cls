/**
 * Created by dmeli on 05.11.19.
 */

public with sharing class ParkLocator {
    public static String[] country(String countryName) {
        ParkService.ParksImplPort countryArray =
                new ParkService.ParksImplPort();
        return countryArray.byCountry(countryName);
    }
}