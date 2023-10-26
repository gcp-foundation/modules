data "google_cloud_asset_resources_search_all" "projects" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Project"
  ]
  query = "state:ACTIVE"
}

data "google_project" "projects" {
  for_each = { for project in data.google_cloud_asset_resources_search_all.projects.results : project.name => project }

  project_id = regex(local.regex_name, each.value.name).name
}

locals {
  regex_project = "projects\\/(?P<number>.*)"
  regex_name    = "\\/\\/cloudresourcemanager\\.googleapis\\.com\\/(?P<type>.*)\\/(?P<name>.*)"

  projects = {
    for project in data.google_project.projects : project.name => project
  }
}
