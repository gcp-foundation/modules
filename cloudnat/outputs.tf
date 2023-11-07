output "name" {
  description = "Name of the Cloud NAT"
  value       = local.name
}

output "router_name" {
  description = "Cloud NAT router name."
  value       = local.router_name
}

output "router_nat_id" {
  description = "Cloud NAT router attributes (project, region, router, name)."
  value       = google_compute_router_nat.nat[0].id
}
