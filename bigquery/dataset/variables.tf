variable "name" {
  description = "The name for the bigquery dataset"
  type        = string
}

variable "project" {
  description = "The project for the bigquery dataset"
  type        = string
}

variable "location" {
  description = "The location of the bigquery dataset"
  type        = string
}

variable "delete_contents_on_destroy" {
  description = "Delete contents on destroy"
  type        = bool
  default     = false
}

variable "expiration_days" {
  description = "Number of days to keep data (null = indefinite)"
  type        = number
  default     = null
}

variable "description" {
  description = "The description for the bigquery dataset"
  type        = string
  default     = null
}

variable "labels" {
  description = "The labels for the bigquery dataset"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "The KMS key for the dataset"
  type        = string
  default     = null
}
