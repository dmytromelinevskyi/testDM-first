/**
 * Created by dmeli on 26.03.2021.
 */

({
    // doInit : function(component, event, helper) {
    //     let mydate = component.get("v.item.Date__c");
    //     if(mydate){
    //         component.set("v.formatdate", new Date(mydate));
    //     }
    // },
    packItem: function (component, event, helper) {
        let item = component.get("v.item");
        let updateItem = component.getEvent("updateItem");
        updateItem.setParams({ "item": item });
        updateItem.fire();
    }
});