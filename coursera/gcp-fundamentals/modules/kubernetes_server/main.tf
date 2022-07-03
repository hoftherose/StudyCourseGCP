# resource "null_resource" "enable_service_usage_api" {
#   provisioner "local-exec" {
#     command = "gcloud services enable container.googleapis.com --project ${var.project}"
#   }
# }

resource "google_project_service" "container" {
  project = var.project
  service = "container.googleapis.com"
}

resource "google_container_cluster" "kubernetes" {
  name     = var.cluster_name
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    null_resource.enable_service_usage_api
  ]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_pool_name
  location   = var.zone
  cluster    = google_container_cluster.kubernetes.name
  node_count = var.num_nodes

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
  }
}