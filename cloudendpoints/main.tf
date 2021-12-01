terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.1.0"
    }
  }
}

provider "google" {
  project = "terraformtests-333814"
  region  = "us-west1"
  zone    = "us-west1-b"
}
