resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command = "gcloud services enable sqladmin.googleapis.com servicenetworking.googleapis.com --project ${var.project}"
  }
}

data "google_compute_network" "vpc" {
  project = var.project
  name = "default"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${data.google_compute_network.vpc.name}-ips"
  purpose       = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network       = "${data.google_compute_network.vpc.name}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network       = "${data.google_compute_network.vpc.self_link}"
  service       = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}

module "computer_engine" {
  source = "../computer_engine"
  project = var.project

  instance_name = var.instance_name
  instance_type = var.instance_type
  startup_script = var.startup_script

  depends_on = [
    google_sql_database_instance.main
  ]
}

resource "google_sql_database_instance" "main" {
  name             = "lamp-instance"
  database_version = "MYSQL_8_0"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project}/global/networks/${data.google_compute_network.vpc.name}"
    }
  }
}

resource "google_sql_user" "users" {
  name     = "default_user"
  instance = google_sql_database_instance.main.name
  password = var.db_password
}

# google_compute_network.private_network.id
# sqladmin.googleapis.com