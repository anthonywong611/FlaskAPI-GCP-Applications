resource "google_container_cluster" "primary" {
  name = "flask-cluster"
  location = var.zone

  min_master_version = var.min_master_version
  node_version       = var.node_version
  enable_legacy_abac = false
  initial_node_count = var.gke_num_nodes[terraform.workspace]

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    disk_size_gb = 10
    machine_type = var.gke_node_machine_type
    tags         = ["gke-node"]
  }
}

