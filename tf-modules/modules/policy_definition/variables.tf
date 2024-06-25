variable "target_resource_name" {
  type = string
  description = "Name of the target resource to create the policy name (policy-<target_resource_name>-<policy_name>)"
}

variable "resource_id" {
  type = string
  description = " (Required) The ID of the Resource (or Resource Scope) where this should be applied."
}

variable "parameters_policy" {
  type = any
  description = "Parameters to apply the policy"
}

variable "enabled" {
  type = bool
  description = "parameter used to enable (true) or disable (false) the policy"
  default = true
}

variable "policy_name" {
  type = string
  description = "The name of the policy this must be unique"
}

variable "display_name" {
  type = string
  description = "The display name of the azure policy"
}