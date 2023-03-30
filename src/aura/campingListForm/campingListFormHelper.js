/**
 * Created by dmeli on 31.03.2021.
 */

({
    addItem: function(component, newItem) {
        let createEvent = component.getEvent("addItem");
        createEvent.setParams({ "item": newItem });
        createEvent.fire();
        component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c',
            'Name': '',
            'Quantity__c': 0,
            'Price__c': 0,
            'Packed__c': false });
    },
});