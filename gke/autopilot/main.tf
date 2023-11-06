resource "google_container_cluster" "gke-cluster" {
  name     = var.name
  location = var.location

  network    = var.network
  subnetwork = var.subnetwork



  enable_autopilot    = true
  deletion_protection = false

  ip_allocation_policy {

    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr
    services_ipv4_cidr_block = var.services_ipv4_cidr

  }
  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr
  }

  release_channel {

    channel = "STABLE"
  }
}