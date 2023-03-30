/**
 * Created by dmeli on 31.03.2021.
 */

({
    clickCreateItem: function (component, event, helper) {
        let validCampingItem = component.find('campingForm').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (validCampingItem) {
            let newItem = component.get("v.newItem");
            console.log("Create new utem: " + JSON.stringify(newItem));
            helper.addItem(component, newItem);
        }
    },
});