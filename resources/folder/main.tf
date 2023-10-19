locals {
  folder_level_1 = [for folder in var.folder_list : folder if folder.parent == null]
  folder_level_2 = setsubtract(distinct([for folder in var.folder_list : folder.parent == null ? {} : contains(local.folder_level_1.*.display_name, folder.parent) ? folder : {}]), [{}])
  folder_level_3 = setsubtract(distinct([for folder in var.folder_list : folder.parent == null ? {} : contains(local.folder_level_2.*.display_name, folder.parent) ? folder : {}]), [{}])
}

resource "google_folder" "folder_level_1" {
  for_each     = { for folder in local.folder_level_1 : folder.display_name => folder }
  display_name = each.value.display_name
  parent       = var.parent_name
}

resource "google_folder" "folder_level_2" {
  for_each     = { for folder in local.folder_level_2 : folder.display_name => folder }
  display_name = each.value.display_name
  parent       = each.value.parent
}

resource "google_folder" "folder_level_3" {
  for_each     = { for folder in local.folder_level_3 : folder.display_name => folder }
  display_name = each.value.display_name
  parent       = each.value.parent
}
