variable "parent" {
  description = "The parent of the policies"
  type        = string
}

variable "policies" {
  description = "A list of policies"
  type = list(object({
    policy = object({
      name = string
      spec = object({
        rules = list(object({
          enforce  = optional(bool)
          allowAll = optional(bool)
          denyAll  = optional(bool)
          values = optional(object({
            allowedValues = optional(list(string), null)
            deniedValues  = optional(list(string), null)
          }), null)
        }))
      })
    })
  }))
}
