/**
 * Created by dmeli on 30.03.2021.
 */

({
    addItem: function (component, newItem) {
        this.saveItem(component, newItem, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let theItems = component.get("v.items");
                theItems.push(response.getReturnValue());
                component.set("v.items", theItems);
            }
        });
    },
    updateItem: function (component, newItem) {
        this.saveItem(component, newItem);
    },
    saveItem: function (component, newItem, callback) {
        let action = component.get("c.saveItem");
        action.setParams({
            "item": newItem
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
})