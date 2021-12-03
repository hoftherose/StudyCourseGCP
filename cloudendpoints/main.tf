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
