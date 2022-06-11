data "google_compute_network" "vpc" {
  project = var.project
  name = "default"
}

module "computer_engine" {
  source = "../computer_engine"
  project = var.project
  zone = var.zone
  region = var.region

  instance_name = var.instance_name
  instance_type = var.instance_type
  startup_script = var.startup_script
}

resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.vpc.id
    }
  }
}

# google_compute_network.private_network.id