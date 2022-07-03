resource "google_folder_iam_policy" "folder_policy" {
  folder      = google_folder.billing_folder.name
  policy_data = data.google_iam_policy.project_creator.policy_data
}

data "google_iam_policy" "project_creator" {
  binding {
    role = "roles/resourcemanager.projectCreator"
    members = [
      "user:${local.user}",
    ]
  }
}
