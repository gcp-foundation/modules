variable "policy" {
  description = "The policy to apply"
}

variable "members" {
  description = "A map of member name to member objects"
  type        = map(object)
  default     = {}
}
