provider "google" {
     project     = data.google_project.billing_manager_template.project_id
     region      = "us-west4"
     zone        = "us-west4-a"
}

resource "google_project" "billing_manager_template" {
    name             = "BillingManagerTemplate"
    project_id       = "billing-manager-template-9876"

    billing_account  = data.google_billing_account.billing_account.id
}

data "google_billing_account" "billing_account" {
    display_name     = "BillingAccountTemplate"
    open             = true
}