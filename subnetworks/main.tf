

resource "google_compute_subnetwork" "subnet" {
  project = var.project
  name          = var.subnet-name
  ip_cidr_range = var.ip_cidr_range
  network       = var.vpc-name
  region        = var.region
  purpose       = var.purpose
  description   = var.description

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges_array
    content {
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
      range_name    = secondary_ip_range.value.range_name
    }
  }

  private_ip_google_access = var.private_ip_google_access
  # private_ipv6_google_access = "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"
  #checkov:skip=CKV_GCP_76: "Ensure that private_ip_google_access is enabled for Subnet" - For testing purposes only

  dynamic "log_config" {
    for_each = var.log_config_array
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }
}
