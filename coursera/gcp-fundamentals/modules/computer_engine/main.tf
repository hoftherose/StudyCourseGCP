resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command = "gcloud services enable serviceusage.googleapis.com compute.googleapis.com --project ${var.project}"
  }
}

resource "time_sleep" "api_init" {
  create_duration = "15s"

  depends_on = [null_resource.enable_service_usage_api]
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.instance_type

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

  metadata_startup_script = var.startup_script

  depends_on = [time_sleep.api_init]
}

resource "google_compute_firewall" "http" {
  name    = "default-allow-http"
  network = "default"

  allow {
      protocol = "tcp"
      ports = ["80"]
  }
  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]

  depends_on = [time_sleep.api_init]
}
