resource "google_cloudbuild_trigger" "on-push-frontend-rebuild" {
  name = "frontend-trigger"
  trigger_template {
    branch_name = "main"
    repo_name   = "github_pahol21_ccc-gr13-f23-frontend"
  }
  filename        = "cloudbuild_frontend.yaml"
}

resource "google_cloudbuild_trigger" "on-push-backend-rebuild" {
  name = "backend-trigger"
  trigger_template {
    branch_name = "main"
    repo_name   = "github_pahol21_ccc-gr13-f23-backend"
  }
  filename        = "cloudbuild_backend.yaml"
}