variable "zone" {
  description = "Region of resources"
}

variable "min_master_version" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "node_version" {
  description = "Version of nodes in each GKE cluster zone"
}

variable "gke_num_nodes" {
  type        = map(string)
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_node_machine_type" {
  description = "Machine type of GKE nodes"
}

# k8s variables
variable gke_label {
  type        = map(string)
  description = "label"
}