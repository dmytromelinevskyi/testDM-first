/**
 * Created by dmeli on 05.04.2021.
 */

({
    validateContactForm: function(component) {
        var validContact = true;
        // Show error messages if required fields are blank
        var allValid = component.find('contactField').reduce(function (validFields, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validFields && inputCmp.get('v.validity').valid;
        }, true);
        if (allValid) {
            // Verify we have an account to attach it to
            var account = component.get("v.newContact");
            if($A.util.isEmpty(account)) {
                validContact = false;
                console.log("Quick action context doesn't have a valid account.");
            }
            return(validContact);
        }
    }
})