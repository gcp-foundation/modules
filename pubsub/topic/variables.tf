variable "name" {
  description = "The name of the topic"
  type        = string
}

variable "project" {
  description = "The project for the topic"
  type        = string
}

variable "kms_key_id" {
  description = "The kms key id for the topic"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for the topic"
  type        = map(string)
  default     = {}
}
