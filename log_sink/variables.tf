variable "name" {
  description = "The name of the log sink"
  type        = string
}

variable "org_id" {
  description = "The organization of the log sink"
  type        = string
  default     = null
}

variable "filter" {
  description = "The filter for the log sink"
  type        = string
}

variable "destination" {
  description = "Destination for the log sink"
  type        = string
}

variable "include_children" {
  description = "Flag to include children"
  type        = bool
  default     = true
}

variable "exclusions" {
  description = "The exclusions to apply to the log sink"
  type        = list(any)
  default     = null
}
