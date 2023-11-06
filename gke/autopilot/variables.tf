variable "name" {
  description = "The name of gke cluster"
  type        = string
}

variable "location" {
  description = "The location of gke cluster"
  type        = string
}
variable "network" {
  description = "The VPC for gke cluster"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork for gke cluster"
  type        = string
}

variable "cluster_ipv4_cidr" {
  description = "Cluster IPV4 cidr range"

}

variable "services_ipv4_cidr" {
  description = "Services Ipv4 cidr range"


}

variable "enable_private_endpoint" {
  description = "Gke private endpoint"
  type        = bool

}
variable "master_ipv4_cidr" {
  description = "Gke master ipv4 cidr range"
  type        = string


}