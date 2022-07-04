output "name" {
  value = google_artifact_registry_repository.repo.name
  description = "The full name of the repository in the registry"
}