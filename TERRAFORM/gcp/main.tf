terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Activer l'API Cloud Run
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

# Déployer sur Cloud Run
resource "google_cloud_run_v2_service" "kgt_app" {
  name     = "${var.app_name}-tf"
  location = var.region


  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.app_name}/${var.app_name}:v1.0"
      ports {
        container_port = 8080
      }
    }
  }

  depends_on = [google_project_service.run]
}

# Rendre le service public
resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.kgt_app.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
