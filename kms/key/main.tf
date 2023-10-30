locals {
  key_ring = var.key_ring != null ? var.key_ring : google_kms_key_ring.key_ring[0].id
  key      = var.prevent_destroy ? google_kms_crypto_key.prod_key[0].id : google_kms_crypto_key.dev_key[0].id
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "google_kms_key_ring" "key_ring" {
  count    = var.key_ring != null ? 0 : 1
  name     = var.key_ring_name
  project  = var.project
  location = var.location
}

resource "google_kms_crypto_key" "dev_key" {
  count                      = var.prevent_destroy ? 0 : 1
  name                       = var.name
  key_ring                   = local.key_ring
  rotation_period            = var.rotation_period
  destroy_scheduled_duration = var.destroy_scheduled_duration
  purpose                    = var.purpose
  labels                     = var.labels

  dynamic "version_template" {
    for_each = var.algorithm != null ? [1] : []

    content {
      algorithm        = var.algorithm
      protection_level = var.protection_level
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_kms_crypto_key" "prod_key" {
  count                      = var.prevent_destroy ? 1 : 0
  name                       = var.name
  key_ring                   = local.key_ring
  rotation_period            = var.rotation_period
  destroy_scheduled_duration = var.destroy_scheduled_duration
  purpose                    = var.purpose
  labels                     = var.labels

  dynamic "version_template" {
    for_each = var.algorithm != null ? [1] : []

    content {
      algorithm        = var.algorithm
      protection_level = var.protection_level
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  crypto_key_id = local.key
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  members       = var.encrypters
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  crypto_key_id = local.key
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  members       = var.decrypters
}

