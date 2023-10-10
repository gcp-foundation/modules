resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.name
  project                     = var.project
  location                    = var.location
  description                 = var.description
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  default_table_expiration_ms = var.expiration_days == null ? null : var.expiration_days * 864 * pow(10, 5)
  labels                      = var.labels

  dynamic "default_encryption_configuration" {
    for_each = var.kms_key_id == null ? [] : [var.kms_key_id]
    content {
      kms_key_name = var.kms_key_id
    }
  }
}
