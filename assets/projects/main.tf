data "google_cloud_asset_resources_search_all" "projects" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Project"
  ]
  query = "state:ACTIVE"
}

locals {
  projects = {
    for project in data.google_cloud_asset_resources_search_all.projects.results :
    project.display_name => { project_id = substr(project.name, 47, -1), number = substr(project.project, 9, -1) }
  }
}
