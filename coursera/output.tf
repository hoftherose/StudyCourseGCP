output "folder_id" {
  value = google_folder.coursera_folder.name
}

output "project_id" {
  value = google_project.coursera_tfstate.project_id
}

output "storage_bucket" {
  value = google_storage_bucket.gcp_fundamentals.name
}