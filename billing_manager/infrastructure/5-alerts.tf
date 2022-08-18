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

  budget_filter {
    credit_types_treatment = "EXCLUDE_ALL_CREDITS"
  }
  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.monitoring_channel.id,
    ]
    disable_default_iam_recipients = true
  }
}
