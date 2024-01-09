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

resource "google_bigquery_dataset" "combined_logs" {
  dataset_id                  = "combined_logs"
  friendly_name               = "Combined Logs For All Services"
  description                 = "A dataset for storing logs"
  location                    = "EU"  // Specify the region
  project                     = "ccc-gr13-f23"
  // Additional options can be set according to your requirements.
}

resource "google_logging_project_sink" "top_level_sink" {
  name           = "project-sink"
  destination    = "bigquery.googleapis.com/projects/${google_bigquery_dataset.combined_logs.project}/datasets/${google_bigquery_dataset.combined_logs.dataset_id}"
  filter         = "resource.type=\"cloud_run_revision\" OR resource.type=\"storage.googleapis.com/Bucket\" OR resource.type=\"cloudsql.googleapis.com/Instance\""

  unique_writer_identity = true
}

resource "google_project_iam_binding" "bigquery_data_editor_binding" {
  project                     = "ccc-gr13-f23"
  role                        = "roles/bigquery.dataEditor"

  members = [
    "serviceAccount:${google_logging_project_sink.top_level_sink.writer_identity}"
  ]
}