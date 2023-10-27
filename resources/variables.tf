variable "config" {
  description = "The resource configuration to create"
  type = map(object({
    organizations = list(object({
      displayName = string
      folders = optional(list(object({
        displayName = string
        projects = options(list(object({
          displayName     = string
          labels          = string
          services        = optional(list(string))
          serviceAccounts = optional(list(any))
          keyRings        = optional(list(any))
          storage         = optional(list(any))
        })))
      })))
      projects = options(list(any)) # not used
    }))
  }))
}

variable "billing_account" {
  description = "The default billing account to use for projects"
  type        = string
  default     = null
}

variable "labels" {
  description = "The default labels to be use for resources"
  type        = map(string)
  default     = null
}
