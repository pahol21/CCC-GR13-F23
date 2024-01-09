# Cloud SQL Database Instance
resource "google_sql_database_instance" "default" {
  name             = "order-database-instance"
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
  name     = "order-database"
  instance = google_sql_database_instance.default.name
}

# Cloud SQL User
resource "google_sql_user" "users" {
  name     = "admin_user"
  instance = google_sql_database_instance.default.name
  password = "admin_password"
}