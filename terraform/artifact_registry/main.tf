resource "google_artifact_registry_repository" "repo" {
  provider = google-beta

  project = var.project_id
  repository_id = "flask-repo"
  location = var.region
  description = "Cloud SQL to GKE Applcation"
  format = var.format
}