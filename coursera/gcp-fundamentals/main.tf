terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24.0"
    }
  }

  backend "gcs" {
    bucket  = "gcp_fundamentals_tfstate"
  }
}

resource "google_project" "fundamentals" {
  name       = "gcp-fundamentals-${var.folder_id}"
  project_id = "gcp-fundamentals-${var.folder_id}"
  skip_delete = true

  folder_id     = var.folder_id
  billing_account = data.google_billing_account.billing_account.id
}

data "google_billing_account" "billing_account" {
  display_name = var.billing_account
  open         = true
}

module "computer_engine" {
  source = "./modules/computer_engine"

  project = google_project.fundamentals.project_id
  zone = var.zone
  region = var.region
}