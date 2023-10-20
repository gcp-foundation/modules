variable "folder_list" {
  description = "The display name for the folder"
  type        = list(map(string))
}

variable "parent_name" {
  description = "The Organization id"
  type        = string
}
