variable "parent" {
  description = "The parent of the policies"
  type        = string
}

variable "policies" {
  description = "A list of policies"
  type        = list(any)
}
