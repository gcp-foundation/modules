variable "delete_default_routes_on_create" {
  default     = false
  description = "(Optional) Default routes (0.0.0.0/0) will be deleted immediately after network creation."
  type        = bool
}

variable "description" {
  default     = null
  description = "(Optional) Description of the vpc"
  type        = string
}

variable "name" {
  default     = ""
  description = "Name of the VPC"
  type        = string
}

variable "project" {
  default     = ""
  description = "(Optional) Name of the project"
  type        = string
}

variable "routing_mode" {
  default     = "GLOBAL"
  description = "(Optional) Network-wide routing mode to use. (REGIONAL||GLOBAL)"
  type        = string
}
