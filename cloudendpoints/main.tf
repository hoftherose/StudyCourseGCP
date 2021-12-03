terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.1.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_app_engine_flexible_app_version" "app" {
  version_id = "v1"
  runtime = "custom"
  service = "default"

  deployment {
    container {
      image = data.google_container_registry_image.app_image.image_url
    }
  }

  manual_scaling {
    instances = var.num_instances
  }

  readiness_check {
    path = "/"
  }
  liveness_check {
    path = "/"
  }
}

resource "google_project_service" "service" {
  project = var.project_id
  service = "appengineflex.googleapis.com"

  disable_dependent_services = false
}

resource "google_project_iam_member" "gae_api" {
  project = var.project_id
  role    = "roles/compute.networkUser"
  member  = var.app_service_account
}