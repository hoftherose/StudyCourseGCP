variable "user" {
  type = string
}

variable "org_id" {
  type = string
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}

variable "service_account" {
  type        = string
  description = "GCP Service Account to impersonate"
}

locals {
  region = "us-east1"

  org_id       = var.org_id
  organization = "organizations/${local.org_id}"

  project_name = "billing-alerts"
  project_id   = "${local.project_name}-${random_integer.rand.result}"

  billing_account = var.billing_account
  user            = var.user
  service_account = var.service_account
  project_apis    = ["cloudresourcemanager.googleapis.com", "pubsub.googleapis.com", "cloudbilling.googleapis.com", "serviceusage.googleapis.com"]
  
  service_account_permissions    = ["roles/resourcemanager.folderEditor", "roles/billing.projectManager", "roles/resourcemanager.projectCreator", "roles/owner"]
}
