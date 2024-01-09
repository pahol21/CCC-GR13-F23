
# Create a new GCS bucket for frontend static website hosting
resource "google_storage_bucket" "frontend_bucket" {
  name          = "cloud-frontend-bucket"
  location      = "EU"
  storage_class = "STANDARD"
  force_destroy = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "https://http.cat/404"
  }
}

# Make the GCS bucket publicly readable so that it can serve the website
resource "google_storage_bucket_iam_binding" "frontend_public_read" {
  bucket = google_storage_bucket.frontend_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

# Create a Google Cloud Load Balancer
resource "google_compute_backend_bucket" "backend_bucket" {
  name        = "frontend-backend-bucket"
  bucket_name = google_storage_bucket.frontend_bucket.name

  enable_cdn = true
}

# Frontend configuration for the load balancer
resource "google_compute_url_map" "url_map" {
  name            = "frontend-url-map"
  default_service = google_compute_backend_bucket.backend_bucket.self_link
}

# Create HTTP(S) load balancer
resource "google_compute_global_forwarding_rule" "default" {
  name       = "frontend-load-balancer"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-lb-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

# Output the website URL
output "website_url" {
  value = "http://${google_storage_bucket.frontend_bucket.name}.storage.googleapis.com"
}