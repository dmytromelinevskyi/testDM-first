/**
 * Created by dmeli on 29.03.2021.
 */

({
    // handleAddItem: function(component, event, helper) {
    //     var newItem = event.getParam("item");
    //     var action = component.get("c.saveItem");
    //     action.setParams({"item": newItem});
    //     action.setCallback(this, function(response){
    //         var state = response.getState();
    //         if (component.isValid() && state === "SUCCESS") {
    //             var items = component.get("v.items");
    //             items.push(item);
    //             component.set("v.items",items);
    //         }
    //     });
    //     $A.enqueueAction(action);
    //
    // },
    handleAddItem: function(component, event, helper) {
        let newItem = event.getParam("item");
        helper.addItem(component, newItem);
    },
    handleUpdateItem: function(component, event, helper) {
        let updatedItem = event.getParam("item");
        helper.updateItem(component, updatedItem);
    },
    doInit: function(component, event, helper) {
        // Create the action
        let action = component.get("c.getItems");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    }
})