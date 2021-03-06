terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24.0"
    }
  }

  backend "gcs" {
    bucket = "gcp_fundamentals_tfstate"
  }
}

provider "google" {
  project = var.project_id
  region  = "us-east1"
  zone    = "us-east1-c"
}

data "google_client_config" "defaults" {
  provider = google
}

##########################################
# Compute engine (NGINX Server)

# module "computer_engine" {
#   source = "./modules/computer_engine"
#   project = data.google_client_config.defaults.project
# #   zone = var.zone
# #   region = var.region

#   instance_name = "my-vm-1"
#   instance_type = "n1-standard-1"
#   startup_script = "compute_engine.sh"
# }

##########################################
# Storage (LAMP Server) Manual steps to be taken in startup script

# module "lamp_server" {
#   source = "./modules/lamp_server"
#   project = data.google_client_config.defaults.project
#   region = data.google_client_config.defaults.region

#   instance_name = "bloghost"
#   instance_type = "n1-standard-1"
#   startup_script = "lamp_server.sh"

#   db_password = var.db_password
# }

##########################################
# Kubernetes (Scalable Nginx K8 Server) run terraform then scripts/kubernetes_nginx.sh

# module "k8_server" {
#   source  = "./modules/kubernetes_server"
#   project = data.google_client_config.defaults.project
#   zone  = data.google_client_config.defaults.zone

#   cluster_name   = "k8-clst"
#   node_pool_name = "k8-np"
#   machine_type   = "n1-standard-1"
# }