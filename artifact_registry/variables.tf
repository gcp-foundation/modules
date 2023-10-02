variable "name" {
  description = "The name of the registry"
  type        = string
}

variable "description" {
  description = "The descriptoin of the registry"
  type        = string
}

variable "project" {
  description = "The project for the registry"
  type        = string
}

variable "location" {
  description = "The location of the registry"
  type        = string
}

variable "format" {
  description = "The format of the registry"
  type        = string
  default     = "DOCKER"
}

variable "kms_key_id" {
  description = "The kms key to encrypt of the registry"
  type        = string
  default     = null
}

variable "labels" {
  description = "The labels for the registry"
  type        = map(string)
  default     = null
}

