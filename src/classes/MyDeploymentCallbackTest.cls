/**
 * Created by dmeli on 24.03.2021.
 */

@IsTest
private class MyDeploymentCallbackTest {
	@IsTest
	static void testMyCallback() {
		// Instantiate the callback.
		Metadata.DeployCallback callback = new PostInstallCallback();
		// Create test result and context objects.
		Metadata.DeployResult result = new Metadata.DeployResult();
		result.numberComponentErrors = 1;
		Metadata.DeployCallbackContext context = new Metadata.DeployCallbackContext();
		// Invoke the callback's handleResult method.
		callback.handleResult(result, context);
	}
}