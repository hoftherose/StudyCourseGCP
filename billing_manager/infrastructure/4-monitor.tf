resource "google_pubsub_topic" "billing_pubsub" {
  project = google_project.billing_project.project_id

  name = "BillingPubsub"
}

resource "google_monitoring_notification_channel" "monitoring_channel" {
  project      = google_project.billing_project.project_id
  display_name = "Test Notification Channel"
  type         = "email"
  labels = {
    email_address = local.user
  }
}
