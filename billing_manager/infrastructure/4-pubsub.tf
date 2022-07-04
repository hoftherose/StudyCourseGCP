resource "google_pubsub_topic" "billing_pubsub" {
  project = google_project.billing_project.project_id

  name = "BillingPubsub"
}