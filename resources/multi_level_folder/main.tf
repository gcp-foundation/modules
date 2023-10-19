locals {
  folder_level_1 = [for folder in var.folder_list : folder if folder.parent == null]
  folder_level_2 = setsubtract(distinct([for folder in var.folder_list : folder.parent == null ? {} : contains(local.folder_level_1.*.displayName, folder.parent) ? folder : {}]), [{}])
  folder_level_3 = setsubtract(distinct([for folder in var.folder_list : folder.parent == null ? {} : contains(local.folder_level_2.*.displayName, folder.parent) ? folder : {}]), [{}])
}

resource "google_folder" "folder_level_1" {
  for_each     = { for folder in local.folder_level_1 : folder.displayName => folder }
  display_name = each.value.displayName
  parent       = var.parent
}

resource "google_folder" "folder_level_2" {
  for_each     = { for folder in local.folder_level_2 : folder.displayName => folder }
  display_name = each.value.displayName
  parent       = google_folder.folder_level_1[each.value.parent].name
}

resource "google_folder" "folder_level_3" {
  for_each     = { for folder in local.folder_level_3 : folder.displayName => folder }
  display_name = each.value.displayName
  parent       = google_folder.folder_level_2[each.value.parent].name
}
