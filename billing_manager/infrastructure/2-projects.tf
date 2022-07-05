resource "google_folder" "billing_folder" {
  display_name = "billing"
  parent       = local.organization
}

resource "google_project" "billing_project" {
  name                = local.project_name
  project_id          = local.project_id
  billing_account     = data.google_billing_account.account.id
  folder_id           = google_folder.billing_folder.folder_id
  auto_create_network = false
}

data "google_billing_account" "account" {
  display_name = local.billing_account
  open         = true
}

resource "google_project_service" "service_api" {
  for_each = toset(local.project_apis)

  project = google_project.billing_project.project_id
  service = each.key
}
