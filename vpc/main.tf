
resource "google_compute_network" "vpc" {
  name                            = var.name
  routing_mode                    = var.routing_mode
  project                         = var.project
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_routes_on_create
  auto_create_subnetworks = false
}
