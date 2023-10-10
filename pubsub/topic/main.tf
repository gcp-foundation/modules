resource "google_pubsub_topic" "topic" {
  name         = var.name
  project      = var.project
  labels       = var.labels
  kms_key_name = var.kms_key_id
}
