output "folder_id" {
  value = flatten([[for folder in local.folder_level_1 : { "${folder.displayName}" = google_folder.folder_level_1[folder.displayName].name }],
    [for folder in local.folder_level_2 : { "${folder.displayName}" = google_folder.folder_level_2[folder.displayName].name }],
  [for folder in local.folder_level_3 : { "${folder.displayName}" = google_folder.folder_level_3[folder.displayName].name }]])
}