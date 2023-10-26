data "google_cloud_asset_resources_search_all" "projects" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Project"
  ]
  query = "state:ACTIVE"
}

locals {
  regex_project = "projects\\/(?P<number>.*)"
  regex_name    = "\\/\\/cloudresourcemanager\\.googleapis\\.com\\/(?P<type>.*)\\/(?P<name>.*)"

  projects = {
    for project in data.google_cloud_asset_resources_search_all.projects.results : project.display_name =>
    {
      project_id = regex(local.regex_name, project.name).name,
      number     = regex(local.regex_project, project.project).number
    }
  }
}
