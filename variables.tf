
variable "project" {
  type = string
}

variable "location" {
  type = string
}

variable "gcr_region" {
  type = string
}

variable "service_name" {
  type    = string
  default = "cloudrun-demo"
}

variable "image_name" {
  type    = string
  default = "gcr.io/cloudrun/hello"
}

variable "branch_name" {
  type    = string
  default = "master"
}

variable "digest" {
  type    = string
  default = "latest"
}

variable "github_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

