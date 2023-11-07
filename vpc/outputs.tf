output "network" {
  value       = google_compute_network.vpc.name
  description = "VPC network or legacy network resource on GCP"
}

output "id" {
  description = "ID of GCP compute network"
  value       = google_compute_network.vpc.id
}
