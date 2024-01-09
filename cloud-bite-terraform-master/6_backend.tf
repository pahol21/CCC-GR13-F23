
# Cloud Run Service for NestJS Backend
resource "google_cloud_run_service" "nestjs_service" {
  name     = "nestjs-backend-service"
  location = "europe-west1"
  
   template {
    spec {
      containers {
        image = "gcr.io/ccc-gr13-f23/nestjs-backend:latest"
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

output "nestjs_service_url" {
  value = google_cloud_run_service.nestjs_service.status[0].url
}
