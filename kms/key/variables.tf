variable "name" {
  description = "The name of the key"
  type        = string
}

variable "prevent_destroy" {
  description = "Prevent the destruction of the key?"
  type        = bool
  default     = false
}

variable "rotation_period" {
  description = "The rotation period for the key"
  type        = string
  default     = null
}

variable "destroy_scheduled_duration" {
  description = "The destroy scheduled duration for the key"
  type        = string
  default     = null
}

variable "key_ring" {
  description = "The key ring identifier - creates a key ring if null"
  type        = string
  default     = null
}

variable "purpose" {
  description = "The purpose of the key"
  type        = string
  default     = null
}

variable "algorithm" {
  description = "The algorithm for the key"
  type        = string
}

variable "protection_level" {
  description = "The algorithm for the key"
  type        = string
}

variable "labels" {
  description = "The labels to apply to the key"
  type        = map(string)
  default     = null
}

variable "key_ring_name" {
  description = "The key ring name - required if key_ring is null"
  type        = string
  default     = null
}

variable "project" {
  description = "The project to create the key ring - required if key_ring is null"
  type        = string
  default     = null
}

variable "location" {
  description = "The location to create the key ring - required if key_ring is null"
  type        = string
  default     = null
}

