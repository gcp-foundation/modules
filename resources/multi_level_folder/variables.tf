variable "folder_list" {
  description = "The display name for the folder"
  type        = list(map(string))
}

variable "parent" {
  description = "The Organization id"
  type        = string
}