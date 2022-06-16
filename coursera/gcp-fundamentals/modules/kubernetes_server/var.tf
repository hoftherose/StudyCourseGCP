variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "num_nodes" {
  type    = number
  default = 1
}

variable "preemptible" {
  type    = bool
  default = true
}