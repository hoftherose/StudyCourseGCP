resource "google_compute_instance" "default" {
  name         = "my-vm-1"
  machine_type = "n1-standard-1"
  zone         = var.zone

  tags = ["compute", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "SCSI"
#   }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "echo hi > /test.txt"

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = var.service_account
#     scopes = ["cloud-platform"]
#   }
}