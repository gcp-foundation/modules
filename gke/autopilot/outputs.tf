output "name" {
  value = google_container_cluster.gke-cluster.name
}

output "cluster_ipv4_cidr" {
  value = google_container_cluster.gke-cluster.cluster_ipv4_cidr

}

output "services_ipv4_cidr" {
  value = google_container_cluster.gke-cluster.services_ipv4_cidr

}
output "master_ipv4_cidr" {
  value = google_container_cluster.gke-cluster.master_version

}