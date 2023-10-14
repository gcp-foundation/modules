output "folders" {
  value = local.folders
}

output "search" {
  value = data.google_cloud_asset_resources_search_all.folders.results
}
