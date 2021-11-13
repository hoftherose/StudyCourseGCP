provider "google" {
     region      = "us-west4"
     zone        = "us-west4-a"
}

data "google_billing_account" "billing_account" {
    display_name     = "Billing"
    open             = true
}

resource "google_project" "billing_manager_template" {
    name             = "BillingManagerTemplate"
    project_id       = "billing-manager-template-9876"

    billing_account  = data.google_billing_account.billing_account.id
}

resource "google_billing_budget" "budget_alert" {
    billing_account = data.google_billing_account.billing_account.id
    display_name = "Example Billing Budget Template"
    amount {
        specified_amount {
        currency_code = "MEX"
        units = "100"
        }
    }
    threshold_rules {
        threshold_percent =  0.1
    }
    threshold_rules {
        threshold_percent =  0.3
    }
    threshold_rules {
        threshold_percent =  1.0
    }
    threshold_rules {
        threshold_percent = 0.5
        spend_basis = "FORECASTED_SPEND"
    }
    threshold_rules {
        threshold_percent = 1.0
        spend_basis = "FORECASTED_SPEND"
    }
    all_updates_rule {
        pubsub_topic = resource.google_pubsub_topic.billing_pubsub_template.id
    }
}