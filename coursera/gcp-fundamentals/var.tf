variable "project_id" {
  type    = string
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-b"
}

variable "db_password" {
  type    = string
}