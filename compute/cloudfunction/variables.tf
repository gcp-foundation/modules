variable "name" {
  description = "The name for the cloud function"
  type        = string
}

variable "project" {
  description = "The project for the cloud function"
  type        = string
}

variable "location" {
  description = "The location for the cloud function"
  type        = string
}

variable "service_account_email" {
  description = "The service account for the cloud function"
  type        = string
}

variable "source_archive_bucket" {
  description = "The storage bucket for the cloud function source code"
  type        = string
}

variable "source_archive_object" {
  description = "The name of the source code file in the storage bucket"
  type        = string
}

variable "entry_point" {
  description = "The entry point in the source code for the cloud function"
  type        = string
}

variable "pubsub_topic_name" {
  description = "The name of the pubsub topic that will trigger this cloud function"
  type        = string
}

variable "kms_key_id" {
  description = "The kms key to encrypt the cloud function"
  type        = string
  default     = null
}

variable "docker_repository" {
  description = "The docker repository for the cloud unction source code"
  type        = string
  default     = null
}

variable "vpc_connector" {
  description = "The VPC Access Connector for the cloud function"
  type        = string
  default     = null
}

variable "description" {
  description = "The description for the cloud function"
  type        = string
  default     = null
}

variable "runtime" {
  description = "The runtime for the cloud function"
  type        = string
  default     = "python311"
}

variable "labels" {
  description = "Labels for the cloud function"
  type        = map(string)
  default     = {}
}

variable "available_memory_mb" {
  description = "The amount of memory for the cloud function"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the cloud function"
  type        = map(string)
  default     = null
}

