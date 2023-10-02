output "key_id" {
  value = local.key
}

output "key_ring_id" {
  value = local.key_ring
}

output "encrypters" {
  value = google_kms_crypto_key_iam_binding.encrypters
}

output "decrypters" {
  value = google_kms_crypto_key_iam_binding.decrypters
}
