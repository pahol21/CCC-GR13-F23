#Images
resource "google_storage_bucket" "frontend_images_bucket" {
  name          = "cloud-frontend-images-bucket"
  location      = "EU"
  storage_class = "STANDARD"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "https://http.cat/404"
  }
}
resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.frontend_images_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

output "frontend_images_bucket_url" {
  value = "http://${google_storage_bucket.frontend_images_bucket.name}.storage.googleapis.com"
}