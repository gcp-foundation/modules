resource "random_string" "random_num" {
  length    = 4
  min_lower = 4
  special   = false
}

data "google_organization" "organization" {
  domain = var.domain
}
