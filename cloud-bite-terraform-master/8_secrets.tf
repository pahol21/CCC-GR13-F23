resource "google_secret_manager_secret" "db_host" {
  secret_id   = "db-host"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_host" {
  secret      = google_secret_manager_secret.db_host.id
  secret_data = "34.78.239.225" 
}

resource "google_secret_manager_secret" "db_username" {
  secret_id   = "db-username"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_username" {
  secret      = google_secret_manager_secret.db_username.id
  secret_data = "admin_user" 
}

resource "google_secret_manager_secret" "db_password" {
  secret_id   = "db-password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = "admin_password"  # Replace with your actual DB password
}

resource "google_secret_manager_secret" "db_database" {
  secret_id   = "db-database"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_database" {
  secret      = google_secret_manager_secret.db_database.id
  secret_data = "order-database" 
}