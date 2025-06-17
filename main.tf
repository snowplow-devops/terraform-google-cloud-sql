resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name = "${var.name}-${random_id.db_name_suffix.hex}"

  region           = var.region
  database_version = var.database_version

  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = "REGIONAL"
    edition           = var.edition

    disk_autoresize = true
    disk_type       = "PD_SSD"

    backup_configuration {
      enabled    = true
      start_time = "01:00"
    }

    ip_configuration {
      ipv4_enabled = true
      ssl_mode     = var.ssl_mode

      dynamic "authorized_networks" {
        for_each = var.authorized_networks

        content {
          name  = authorized_networks.value["name"]
          value = authorized_networks.value["value"]
        }
      }
    }

    user_labels = var.labels
  }

  timeouts {
    create = "60m"
    update = "30m"
    delete = "60m"
  }
}

resource "google_sql_database" "db" {
  name      = var.db_name
  instance  = google_sql_database_instance.instance.name
  charset   = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "user" {
  instance = google_sql_database_instance.instance.name
  name     = var.db_username
  password = var.db_password
}
