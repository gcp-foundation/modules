locals {
  bigquery_options = []
}

resource "google_logging_organization_sink" "sink" {
  name             = var.name
  org_id           = var.org_id
  filter           = var.filter
  include_children = var.include_children
  destination      = var.destination

  dynamic "bigquery_options" {
    for_each = local.bigquery_options
    content {
      use_partitioned_tables = bigquery_options.value.use_partitioned_tables
    }
  }

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = exclusions.value.disabled
    }
  }
}
