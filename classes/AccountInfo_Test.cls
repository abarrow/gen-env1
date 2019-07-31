/**
 * Created by anthony on 2019-05-24.
 */

@isTest
private class AccountInfo_Test {
    // testing 1 2 3 4 5 6
    static testMethod void test1() {
        System.assertEquals(10, new AccountInfo().getCalculatedValue(3,7));
    }
}