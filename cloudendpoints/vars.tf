variable "project_id" {
  type    = string
  default = "terraformtest-333814"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-b"
}

variable "num_instances" {
  type    = number
  default = 1
}

variable "app_service_account" {
  type    = string
  default = "serviceAccount:terraformtest-333814@appspot.gserviceaccount.com"
}
