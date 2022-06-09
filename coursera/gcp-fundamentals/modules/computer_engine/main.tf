resource "google_compute_instance" "default" {
  project = var.project
  name         = "my-vm-1"
  machine_type = "n1-standard-1"
  zone         = var.zone

  tags = ["compute", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "sudo apt update; sudo apt install nginx"
}

resource "google_compute_firewall" "http" {
  project = var.project
  name    = "default-allow-http"
  network = "default"

  allow {
      protocol = "tcp"
      ports = ["80"]
  }
  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}