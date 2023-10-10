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


provider "google" {
    project = "ccc-gr13-f23"
    region = "europe-west1"
    zone = "europe-west1-b"
}
