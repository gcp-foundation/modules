resource "google_kms_key_ring" "key_ring" {
  name     = var.keyring_name
  project  = var.project
  location = var.location
}
