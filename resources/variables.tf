variable "config" {
  description = "The resource configuration to create"

  # type = list(object({
  #   displayName = string
  #   folders = list(object({
  #     displayName = string
  #   }))
  #   projects = list(object({
  #     displayName = string
  #   }))
  # }))
}

variable "billing_account" {
  description = "The default billing account to use for projects"
  type        = string
  default     = null
}
