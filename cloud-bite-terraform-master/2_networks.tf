resource "google_compute_network" "vpc_network" {
  name = "terraform13-network"
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = "vpc-connector"
  project       = "ccc-gr13-f23"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.name  
  ip_cidr_range = "10.8.0.0/28"
  min_throughput = 200
  max_throughput = 300
}

resource "google_project_service" "service_networking" {
  project = "ccc-gr13-f23"
  service = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

# Reserve a range for the Service Networking Connection
resource "google_compute_global_address" "private_ip_address" {
  provider            = google
  name                = "google-sql-private-ip-range"
  purpose             = "VPC_PEERING"
  address_type        = "INTERNAL"
  prefix_length       = 16
  network             = google_compute_network.vpc_network.self_link
}

# Create the Service Networking Connection
resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google
  network                 = google_compute_network.vpc_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

