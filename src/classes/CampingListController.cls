/**
 * Created by dmeli on 30.03.2021.
 */

public with sharing class CampingListController {
	@AuraEnabled
	public static List<Camping_Item__c> getItems() {
		String[] fieldsToCheck = new String[]{
				'Id', 'Name', 'Quantity__c', 'CreatedDate', 'Price__c',
				'Packed__c'
		};
		Map<String, Schema.SObjectField> fieldDescribeTokens =
				Schema.SObjectType.Camping_Item__c.fields.getMap();
		for (String field : fieldsToCheck) {
			if (!fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
				throw new System.NoAccessException();
			}
		}
		System.debug('TEST DM + asd + ' + [
				SELECT Id, Name, Quantity__c, CreatedDate, Price__c, Packed__c
				FROM Camping_Item__c
		]);
		return [
				SELECT Id, Name, Quantity__c, CreatedDate, Price__c, Packed__c
				FROM Camping_Item__c
		];
	}

	@AuraEnabled
	public static Camping_Item__c saveItem(Camping_Item__c item) {
		upsert item;
		return item;
	}
}