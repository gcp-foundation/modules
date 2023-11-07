


variable "vpc-name" {
  type = string
  description = "Name of VPC"
}

variable "subnet-name" {
  type = string
  description = "Subnet Name"
}
variable "project" {
  type        = string
  description = "Name of the project"
}



/*
  SUBNET
*/
variable "ip_cidr_range" {
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."
}

# variable "network_id" {
#   type        = string
#   description = "The network id for the subnet"
# }

variable "region" {
  type        = string
  description = "The GCP region for this subnetwork."
}

variable "description" {
  type        = string
  description = "(Optional) An description of this resource."
  default     = ""
}

variable "secondary_ip_ranges_array" {
  type        = list(any)
  description = "An array of configurations for secondary IP ranges"
  default     = []
}

variable "private_ip_google_access" {
  type        = bool
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  default     = false
}

variable "log_config_array" {
  type        = list(any)
  default     = []
  description = "Denotes the logging options for the subnetwork flow logs."
  validation {
    condition     = length(var.log_config_array) <= 1
    error_message = "Condition not met for log_config_array: length(var.log_config_array) <= 1 ."
  }
  # validation {
  #   condition = resource_name && contains(
  #     [
  #       "INTERVAL_5_SEC",
  #       "INTERVAL_30_SEC",
  #       "INTERVAL_1_MIN",
  #       "INTERVAL_5_MIN",
  #       "INTERVAL_10_MIN",
  #       "INTERVAL_15_MIN"
  #     ],
  #     var.log_config_array[0].aggregation_interval)
  #     error_message = "Aggregation_interval must be one of these: \nINTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN."
  #     }

  # validation {
  #   condition = contains(
  #     [
  #       "INCLUDE_ALL_METADATA",
  #       "EXCLUDE_ALL_METADATA",
  #       "INCLUDE_ALL_METADATA",
  #       "CUSTOM_METADATA"
  #       ],
  #     var.log_config_array[0].metadata)
  #     error_message = "Metadata must be one of these: \nINCLUDE_ALL_METADATA, EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA."
  # }
}

variable "purpose" {
  type        = string
  description = "The purpose of the resource. A subnetwork with purpose set to INTERNAL_HTTPS_LOAD_BALANCER is a user-created subnetwork that is reserved for Internal HTTP(S) Load Balancing. If set to INTERNAL_HTTPS_LOAD_BALANCER you must also set the role field."
  default     = null
}

