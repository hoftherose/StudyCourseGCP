terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24.0"
    }
  }

  backend "gcs" {
    bucket  = "gcp_fundamentals_tfstate"
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
# Storage (LAMP Server)

module "lamp_server" {
  source = "./modules/lamp_server"
  project = data.google_client_config.defaults.project
  region = data.google_client_config.defaults.region
  
  instance_name = "bloghost"
  instance_type = "n1-standard-1"
  startup_script = "lamp_server.sh"

  db_password = var.db_password
}