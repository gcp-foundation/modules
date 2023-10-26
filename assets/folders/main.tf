data "google_cloud_asset_resources_search_all" "folders" {
  provider = google-beta

  scope = "organizations/${var.organization_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Folder"
  ]
  query = "state:ACTIVE"
}

data "google_folder" "folders" {
  for_each = { for folder in data.google_cloud_asset_resources_search_all.folders.results : folder.name => folder }

  folder = "${regex(local.regex_name, each.value.name).type}/${regex(local.regex_name, each.value.name).name}"
}

locals {
  regex_name = "\\/\\/cloudresourcemanager\\.googleapis\\.com\\/(?P<type>.*)\\/(?P<name>.*)"

  folders = {
    for folder in data.google_folder.folders : "${folder.parent}/${folder.display_name}" => folder
  }
}
