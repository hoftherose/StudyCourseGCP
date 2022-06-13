terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24.0"
    }
  }
}

resource "google_folder" "coursera_folder" {
  display_name = "Coursera Folder"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder_iam_policy" "folder_policy" {
  folder      = google_folder.coursera_folder.name
  policy_data = data.google_iam_policy.iam_policy.policy_data
}

resource "google_storage_bucket" "gcp_fundamentals" {
  name          = "gcp_fundamentals_tfstate"
  project       = google_project.coursera_tfstate.project_id
  location      = "US"
  force_destroy = true
}

data "google_iam_policy" "iam_policy" {
  binding {
    role = "roles/resourcemanager.projectCreator"

    members = [
      "user:${var.user_email}",
    ]
  }
}
