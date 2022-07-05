resource "google_folder_iam_member" "service_account_iam" {
  for_each = toset(local.service_account_permissions)
  role = each.key
  member = "serviceAccount:${local.service_account}"

  folder = google_folder.billing_folder.folder_id
}
