output "folder_id" {
  value = merge(flatten([[for folder in local.folder_level_1 : { folder.name = google_folder.folder_level_1[folder.name].name }],
    [for folder in local.folder_level_2 : { folder.name = google_folder.folder_level_2[folder.name].name }],
  [for folder in local.folder_level_3 : { folder.name = google_folder.folder_level_3[folder.name].name }]]))
}