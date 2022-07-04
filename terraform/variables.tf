variable "project_id" {
  description = "Project id"
}

variable "region" {
  description = "Region of resources"
}

variable "zone" {
  description = "Zone of resources"
}

variable "name" {
  default = {
    prod = "prod"
    dev  = "dev"
  }

  description = "Name for vpc"
}

# Network variables

variable "subnet_cidr" {
  default = {
    prod = "10.10.0.0/24"
    dev  = "10.240.0.0/24"
  }

  description = "Subnet range"
}

# Cloud SQL variables

variable "availability_type" {
  default = {
    prod = "REGIONAL"
    dev  = "ZONAL"
  }

  description = "Availability type for HA"
}

variable "sql_instance_size" {
  default     = "db-g1-small"
  description = "Size of Cloud SQL instances"
}

variable "sql_disk_type" {
  default     = "PD_SSD"
  description = "Cloud SQL instance disk type"
}

variable "sql_disk_size" {
  default     = "10"
  description = "Storage size in GB"
}

variable "sql_require_ssl" {
  default     = "false"
  description = "Enforce SSL connections"
}

variable "sql_master_zone" {
  default     = "a"
  description = "Zone of the Cloud SQL master (a, b, ...)"
}

variable "sql_connect_retry_interval" {
  default     = 60
  description = "The number of seconds between connect retries."
}

variable "sql_user" {
  default     = "admin"
  description = "Username of the host to access the database"
}

variable "sql_pass" {
  description = "Password of the host to access the database"
}

variable "db_name" {
  description = "Database name inside the Cloud SQL instance"
}

# GKE variables

variable "gke_num_nodes" {
  default = {
    prod = 2
    dev  = 1
  }

  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_node_machine_type" {
  default     = "n1-standard-1"
  description = "Machine type of GKE nodes"
}

variable gke_label {
  default = {
    prod = "prod"
    dev  = "dev"
  }

  description = "label"
}