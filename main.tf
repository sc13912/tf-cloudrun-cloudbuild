terraform {
  required_version = ">= 0.12.7"
}

provider "google" {
  version = "~> 3.16.0"
  region  = var.location
  project = var.project
}


provider "google-beta" {
  version = "~> 2.10"
  region  = var.location
  project = var.project
}


resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.location

  template {
    spec {
      containers {
        image = var.image_name
      }
    }
  }
}


resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}


resource "google_cloudbuild_trigger" "cloud_build_trigger" {

  provider = google-beta

  github {
    owner = var.github_owner
    name  = var.github_repository
    push {
      branch = var.branch_name
    }
  }


  substitutions = {
    _LOCATION     = var.location
    _GCR_REGION   = var.gcr_region
    _SERVICE_NAME = var.service_name
  }

  filename = "cloudbuild.yaml"

}


