output "subnet" {
  value       = google_compute_subnetwork.subnet.name
  description = "The GCP subnet created"
}
