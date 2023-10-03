variable "name" {
  description = "The name of the storage bucket"
  type        = string
}

variable "location" {
  description = "The location of the storage bucket"
  type        = string
}

variable "data_classification" {
  description = "The classification for the data"
  type        = string
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "log_bucket" {
  description = "Log bucket for logging"
  type        = string
  default     = null
}
