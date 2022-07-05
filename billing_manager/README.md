# Billing Manager

Cloud function and pubsub configuration that shuts down projects when reaching a specified threashold. Adding new projects is as simple as adding a budget notification to pubsub topic.

# Prerequisites

Because the api _billingbudgets.googleapis.com_ does not work from GCloud SDK (for security reasons) we instead have to use a service account. Google Cloud indicates that the best practice should be to impersonate the service account, instead of insecurly sharing the service account keys.

The service account to be impersonated must be created manually or through another script and added as a variable.

This service account must have the following permissions:

- Billing Account User
- Billing Account Viewer
- Folder IAM Admin
