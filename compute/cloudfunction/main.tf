resource "google_cloudfunctions_function" "cloudfunction" {
  project = var.project
  region  = var.location

  name        = var.name
  description = var.description
  runtime     = var.runtime

  service_account_email = var.service_account_email

  available_memory_mb   = var.available_memory_mb
  source_archive_bucket = var.source_archive_bucket
  source_archive_object = var.source_archive_object

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = var.pubsub_topic_name
  }

  entry_point = var.entry_point

  kms_key_name      = var.kms_key_id
  docker_repository = var.docker_repository

  ingress_settings              = "ALLOW_INTERNAL_ONLY"
  vpc_connector                 = var.vpc_connector
  vpc_connector_egress_settings = var.vpc_connector == null ? null : "ALL_TRAFFIC"

  environment_variables = var.environment_variables

  labels = var.labels
}
