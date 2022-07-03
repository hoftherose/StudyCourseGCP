variable "org_id" {
  type = string
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}

locals {
  region = "us-east1"
  org_id = var.org_id
  organization = "organizations/${local.org_id}"
  billing_account = var.billing_account
  project_name = "billing-alerts"
  project_id = "${local.project_name}-${random_integer.rand.result}"
}