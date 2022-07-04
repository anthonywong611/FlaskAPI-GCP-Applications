resource "random_id" "id" { 
  # a cloud sql instance name can only be used once in a week
  # using a random prefix can circumvent the issue of using
  # the same name each time an instance is created
  byte_length = 4
  prefix      = "sql-${terraform.workspace}-"
}

resource "google_sql_database_instance" "master" {
  name             = random_id.id.hex
  region           = var.region
  database_version = "POSTGRES_14"

  settings {
    availability_type = var.availability_type[terraform.workspace]
    tier              = var.sql_instance_size
    disk_type         = var.sql_disk_type
    disk_size         = var.sql_disk_size
    disk_autoresize   = true

    ip_configuration {

      require_ssl  = var.sql_require_ssl
      ipv4_enabled = true
    }

    location_preference {
      zone = "${var.region}-${var.sql_master_zone}"
    }
}

resource "google_sql_user" "user" {
  depends_on = [
    google_sql_database_instance.master
  ]

  instance = google_sql_database_instance.master.name
  name     = var.sql_user
  password = var.sql_pass
}

resource "google_sql_database" "database" {
  name = var.db_name
  instance = google_sql_database_instance.master.name
}