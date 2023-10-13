data "google_cloud_asset_resources_search_all" "folders" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Folder"
  ]
  query = "state:ACTIVE"
}

locals {
  folders = {
    for folder in data.google_cloud_asset_resources_search_all.folders.results : folder.display_name => substr(folder.name, 46, -1)
  }
}

