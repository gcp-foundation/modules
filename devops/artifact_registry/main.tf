resource "google_artifact_registry_repository" "repository" {
  provider = google-beta

  repository_id = var.name
  description   = var.description
  project       = var.project
  location      = var.location
  labels        = var.labels
  format        = var.format
  kms_key_name  = var.kms_key_id
}
