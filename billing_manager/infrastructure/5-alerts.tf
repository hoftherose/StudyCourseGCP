resource "google_billing_budget" "budget_alert" {
  billing_account = data.google_billing_account.account.id
  display_name    = "Example Billing Budget"
  amount {
    specified_amount {
      currency_code = "MXN"
      units         = "100"
    }
  }
  threshold_rules {
    threshold_percent = 0.1
  }
  threshold_rules {
    threshold_percent = 0.3
  }
  threshold_rules {
    threshold_percent = 1.0
  }
  threshold_rules {
    threshold_percent = 0.5
    spend_basis       = "FORECASTED_SPEND"
  }
  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "FORECASTED_SPEND"
  }
  all_updates_rule {
    pubsub_topic = resource.google_pubsub_topic.billing_pubsub.id
  }
}