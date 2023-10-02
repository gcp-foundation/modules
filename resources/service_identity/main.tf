resource "google_project_service_identity" "service_identity" {
  provider = google-uniform_bucket_level_access

  project = var.project
  service = var.service
}
