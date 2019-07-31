public with sharing class DefaultText {

        public String getDefaultText(String pUser, String pWarehouse, String pDivision, String pRegion) {
            List<Default_Text__c> defaultTexts = defaultTextsSelector(pUser, pWarehouse, pDivision, pRegion);
            String defaultText = '';

            for (Default_Text__c dt : defaultTexts) {
                switch on Integer.valueOf(dt.Rank__c) {
                    when 15 { if (dt.Region__c == pRegion && dt.Division__c == pDivision && dt.Warehouse__c == pWarehouse && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 14 { if (dt.Division__c == pDivision && dt.Warehouse__c == pWarehouse && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 13 { if (dt.Region__c == pRegion && dt.Warehouse__c == pWarehouse && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 12 { if (dt.Warehouse__c == pWarehouse && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 11 { if (dt.Region__c == pRegion && dt.Division__c == pDivision && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 10 { if (dt.Division__c == pDivision && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 9 { if (dt.Region__c == pRegion && dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 8 { if (dt.User__c == pUser) {defaultText = dt.Default_Text__c;} }
                    when 7 { if (dt.Region__c == pRegion && dt.Division__c == pDivision && dt.Warehouse__c == pWarehouse) {defaultText = dt.Default_Text__c;} }
                    when 6 { if (dt.Division__c == pDivision && dt.Warehouse__c == pWarehouse) {defaultText = dt.Default_Text__c;} }
                    when 5 { if (dt.Region__c == pRegion && dt.Warehouse__c == pWarehouse) {defaultText = dt.Default_Text__c;} }
                    when 4 { if (dt.Warehouse__c == pWarehouse) {defaultText = dt.Default_Text__c;} }
                    when 3 { if (dt.Region__c == pRegion && dt.Division__c == pDivision) {defaultText = dt.Default_Text__c;} }
                    when 2 { if (dt.Division__c == pDivision) {defaultText = dt.Default_Text__c;} }
                    when 1 { if (dt.Region__c.equalsIgnoreCase(pRegion)) {defaultText = dt.Default_Text__c;} }
                }
                if (String.isNotBlank(defaultText)) {break;}    // **IMPORTANT** If default text found then exit this loop
            }
            system.debug('defaultText= ' + defaultText);
            return 'test';
        }

        private list<Default_Text__c> defaultTextsSelector (String pUser, String pWarehouse, String pDivision, String pRegion) {
            String userLikeClause = '%' + pUser + '%';
            String warehouseLikeClause = '%+' + pWarehouse + '+%';
            String divisionLikeClause = '%+' + pDivision + '+%';
            String regionLikeClause = '%+' + pRegion + '%';

            return [SELECT Id, Rank__c, Default_Text__c, User__c, Warehouse__c, Division__c, Region__c
                    FROM Default_Text__c
                    WHERE key__c LIKE :userLikeClause OR
                            key__c LIKE :warehouseLikeClause OR
                            key__c LIKE :divisionLikeClause OR
                            key__c LIKE :regionLikeClause
                    ORDER BY Rank__c DESC];
        }
}