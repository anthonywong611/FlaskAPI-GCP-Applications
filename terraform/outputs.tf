# remote state output
output "project_id" {
  value = var.project_id
}

# Cloud SQL postgresql outputs
output "master_instance_sql_name" {
  value       = module.cloudsql.master_instance_sql_name
  description = "The name of the master instance"
}

# GKE outputs
output "endpoint" {
  value       = module.gke.endpoint
  description = "Endpoint for accessing the master node"
}

# Artifact Repository outputs
output "name" {
  value       = module.registry.name
  description = "Path name of the repository"
}