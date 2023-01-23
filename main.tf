terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
}

provider "google" {
  credentials = file(var.google_key_file)

  project = var.project_id
  region  = "asia-southeast1"
  zone    = "asia-southeast1-a"
}

resource "google_cloud_run_service" "default" {
  name     = "cloud-run-app-h96sfah4j6"
  location = "asia-southeast1"

  template {
    spec {
      containers {
        image = var.container_image
        ports {
          container_port = 4567
        }

        env {
          name  = "DATABASE_URL"
          value = "postgresql:///${var.db_name}?host=/cloudsql/${var.project_id}:asia-southeast1:${var.db_instance_name}&user=${var.db_username}&password=${var.db_password}"
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "2"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.instance.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }
  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "allUsers" {
  provider = google
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_sql_database_instance" "instance" {
  name             = var.db_instance_name
  region           = "asia-southeast1"
  database_version = "POSTGRES_13"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = "true"
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  name     = var.db_username
  password = var.db_password
  instance = google_sql_database_instance.instance.name
}
