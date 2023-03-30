/**
 * Created by dmeli on 27.08.19.
 */

public with sharing class AccountUtils {

    public static List<Account> accountsByState(String state) {
        String accountState = state;
        List<Account> accountMap = new List<Account>([SELECT Id, Name FROM Account WHERE BillingState = :state]);
        return accountMap;
    }
}