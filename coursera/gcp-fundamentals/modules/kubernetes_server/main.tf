resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command = "gcloud services enable container.googleapis.com --project ${var.project}"
  }
}

resource "google_container_cluster" "kubernetes" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    null_resource.enable_service_usage_api
  ]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_pool_name
  location   = var.region
  cluster    = google_container_cluster.kubernetes.name
  node_count = var.num_nodes

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.default.email
    # oauth_scopes    = [
    #   "https://www.googleapis.com/auth/cloud-platform"
    # ]
  }
}