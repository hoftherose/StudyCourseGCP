provider "google" {
  region                      = local.region
  impersonate_service_account = local.service_account
  # Setting up alerts requires a service account to use billingbudgets.googleapis.com
  # credentials path setup in variables
}

resource "random_integer" "rand" {
  min = 1000
  max = 9999
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.27.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3.2"
    }
  }
  backend "gcs" {
    bucket = "tfstates-247"
  }
}
