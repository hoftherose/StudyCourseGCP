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

##########################################
# Compute engine (NGINX Server)

# module "computer_engine" {
#   source = "./modules/computer_engine"
#   project = google_project.fundamentals.project_id
#   zone = var.zone
#   region = var.region

#   instance_name = "my-vm-1"
#   instance_type = "n1-standard-1"
#   startup_script = "apt-get update; apt-get install --no-install-recommends -y nginx"
# }

##########################################
# Storage (LAMP Server)

module "lamp_server" {
  source = "./modules/lamp_server"
  project = google_project.fundamentals.project_id
  zone = var.zone
  region = var.region

  instance_name = "bloghost"
  instance_type = "n1-standard-1"
  startup_script = "apt-get update; apt-get install --no-install-recommends -y apache2 php php-mysql; service apache2 restart"

  db_password = var.db_password
}