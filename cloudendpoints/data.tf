data "google_container_registry_image" "app_image" {
  name = "fastapi-test"
  tag  = "latest"
}

output "name" {
    value = google_app_engine_flexible_app_version.app.service
}
