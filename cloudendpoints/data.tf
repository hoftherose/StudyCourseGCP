data "google_container_registry_image" "app_image" {
  name = "fastapi-test"
  tag  = "1.0"
}
