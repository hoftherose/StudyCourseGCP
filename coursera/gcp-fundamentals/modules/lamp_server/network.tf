data "google_compute_network" "vpc" {
  project = var.project
  name = "default"
}

# resource "google_compute_address" "ip_address" {
#   project = var.project

#   name = "private-ip"
#   address_type = "INTERNAL"
#   prefix_length = 16
#   network = data.google_compute_network.vpc.id
# #   subnetwork   = data.google_compute_subnetwork.subnetwork.id
  
#   address      = "10.142.0.128"
#   region       = "us-east1"
# }

resource "google_compute_global_address" "private_ip_address" {
  project = var.project

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.100.0.0"
#   address       = data.google_compute_subnetwork.subnetwork.ip_cidr_range
  prefix_length = 20
  network       = data.google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
#   project = var.project

  network                 = data.google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
