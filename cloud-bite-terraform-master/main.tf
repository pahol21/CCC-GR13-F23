# Initialize the GCP provider
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    } 
    backend "gcs" {
        bucket = "tfstate-cloud-bite-sdu-13"
        prefix = "terraform/state"
    }
}

provider "google" {
    project = "ccc-gr13-f23"
    region = "europe-west1"
    zone = "europe-west1-a"
}


resource "google_storage_bucket" "default" {
    name = "tfstate-cloud-bite-sdu-13"
    force_destroy ="false"
    location = "EU"
    storage_class = "STANDARD"
    versioning {
        enabled = true
    }
    public_access_prevention = "enforced"
}

# # Create a GCP project
# resource "google_project" "my_project" {
#   name       = "my-project-name"
#   project_id = "my-project-id"
#   org_id     = "your-organization-id" # Optional: If applicable
# }

# # Enable necessary APIs
# resource "google_project_service" "source_repo" {
#   project = google_project.my_project.project_id
#   service = "sourcerepo.googleapis.com"
# }

# resource "google_project_service" "secret_manager" {
#   project = google_project.my_project.project_id
#   service = "secretmanager.googleapis.com"
# }

# resource "google_project_service" "sqladmin" {
#   project = google_project.my_project.project_id
#   service = "sqladmin.googleapis.com"
# }

# # Create a Google Cloud Source Repository git repo
# resource "google_sourcerepo_repository" "my_repo" {
#   name     = "my-repo-name"
#   project  = google_project.my_project.project_id
# }

# Set up IAM roles and invite team members
# Define your IAM roles and bindings here

# Create a Terraform landing zone (if needed)
# Initialize Terraform backend (e.g., Google Cloud Storage)

# Create build pipeline for frontend and backend applications
# Implement your build pipeline configurations here

# Deploy frontend application to Storage Bucket with CDN
# Implement your deployment configurations here

# Deploy backend application to Cloud Run
# Implement your deployment configurations here

# Use Secret Manager to store database sensitive information
# Implement Secret Manager configurations here

# Create Cloud SQL MySQL instance
# Implement Cloud SQL configurations here

# Create secure connection between Cloud Run backend and MySQL instance
# Implement secure connection configurations here

# Implement generative AI and associated resources
# Implement generative AI configurations here

# Implement centralised logging and alerting
# Implement centralized logging and alerting configurations here
