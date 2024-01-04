# Initialize the GCP provider
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    }

    backend "gcs" {
        bucket = "tfstate-cloud-bite-sdu-ccc-13"
        prefix = "terraform/state"
    }
}

provider "google" {
    project = "ccc-gr13-f23"
    region = "europe-west1"
    zone = "europe-west1-b"
}

resource "google_cloudbuild_trigger" "on_push_trigger" {
  project = "ccc-gr13-f23"
  name = "on-push-trigger"
  description = "Trigger for repo"

  trigger_template {
    repo_name = "github_pahol21_ccc-gr13-f23"
    project = "CCC-G13-F23"
    branch_name = "^master$"
  }

  filename = "cloudbuild.yaml"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform13-network"
}

resource "google_storage_bucket" "default" {
    name = "tfstate-cloud-bite-sdu-ccc-13"
    location = "EU"
    force_destroy = false
    storage_class = "STANDARD"
    versioning {
        enabled = true
    }
    public_access_prevention = "enforced"
}

# Create a new GCS bucket for frontend static website hosting
resource "google_storage_bucket" "frontend_bucket" {
  name          = "cloud-frontend-bucket"
  location      = "EU"
  storage_class = "STANDARD"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Make the GCS bucket publicly readable so that it can serve the website
resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.frontend_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

# Output the website URL
output "website_url" {
  value = "http://${google_storage_bucket.frontend_bucket.name}.storage.googleapis.com"
}

# Cloud Run Service for NestJS Backend
resource "google_cloud_run_service" "nestjs_service" {
  name     = "nestjs-backend-service"
  location = "europe-west1"
  
   template {
    spec {
      containers {
        image = "gcr.io/ccc-gr13-f23/nestjs-backend:database"
        ports {
          container_port = 3000
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "nestjs_service_public" {
  location = google_cloud_run_service.nestjs_service.location
  project  = google_cloud_run_service.nestjs_service.project
  service  = google_cloud_run_service.nestjs_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Cloud SQL Database Instance
resource "google_sql_database_instance" "default" {
  name             = "my-database-instance"
  region           = "europe-west1"
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "Allow all inbound"
        value = "0.0.0.0/0"
      }
    }
  }
}

# Cloud SQL Database
resource "google_sql_database" "default" {
  name     = "my-database"
  instance = google_sql_database_instance.default.name
}

# Cloud SQL User
resource "google_sql_user" "users" {
  name     = "admin_user"
  instance = google_sql_database_instance.default.name
  password = "admin_password"
}