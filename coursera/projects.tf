resource "google_project" "coursera_tfstate" {
  name       = "coursera-tfstate"
  project_id = "coursera-tfstate-${var.org_id}"
  skip_delete = true

  folder_id  = google_folder.coursera_folder.name
  billing_account = data.google_billing_account.billing_account.id
}

resource "google_project" "fundamentals" {
  name       = "gcp-fundamentals"
  project_id = "gcp-fundamentals-${google_folder.coursera_folder.folder_id}"
  skip_delete = true

  folder_id     = google_folder.coursera_folder.name
  billing_account = data.google_billing_account.billing_account.id
}

data "google_billing_account" "billing_account" {
  display_name = "My Billing Account"
  open         = true
}