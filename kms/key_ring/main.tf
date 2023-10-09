resource "google_kms_key_ring" "key_ring" {
  name     = var.name
  project  = var.project
  location = var.location
}
