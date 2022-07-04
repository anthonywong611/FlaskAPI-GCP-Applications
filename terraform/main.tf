# configure the project environment
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_container_engine_versions" "northeast2a" {  # TODO: Change the data name
  provider = google
  location = var.zone
}

module "cloudsql" {
  source                     = "./cloudsql"
  region                     = var.region
  availability_type          = var.availability_type
  sql_instance_size          = var.sql_instance_size
  sql_disk_type              = var.sql_disk_type
  sql_disk_size              = var.sql_disk_size
  sql_require_ssl            = var.sql_require_ssl
  sql_master_zone            = var.sql_master_zone
  sql_connect_retry_interval = var.sql_connect_retry_interval
  sql_user                   = var.sql_user
  sql_pass                   = var.sql_pass
  db_name                    = var.db_name
}

module "gke" {
  source                = "./gke"
  zone                  = var.zone
  min_master_version    = "latest"
  node_version          = "latest"
  gke_num_nodes         = var.gke_num_nodes
  gke_node_machine_type = var.gke_node_machine_type
  gke_label             = var.gke_label
}

module "registry" {
  source     = "./registry"
  project_id = var.project_id
  region     = var.region
  format     = "DOCKER"
}