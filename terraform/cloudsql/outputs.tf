output "master_instance_sql_name" {
  value       = google_sql_database_instance.master.name
  description = "The IPv4 address assigned for master"
}