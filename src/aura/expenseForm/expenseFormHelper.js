/**
 * Created by dmeli on 31.03.2021.
 */

({
    createExpense: function(component, newExpense) {
        let createEvent = component.getEvent("createExpense");
        createEvent.setParams({ "expense": newExpense });
        createEvent.fire();
    },
});