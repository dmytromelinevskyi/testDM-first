/**
 * Created by dmeli on 27.08.19.
 */

public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accounts) {
        for(Account acct : accounts) {
            if(acct.ShippingState == null || ( acct.BillingState != null && acct.ShippingState.compareTo(acct.BillingState) != 0)) {
                acct.ShippingState = acct.BillingState;
            }
        }
    }
}