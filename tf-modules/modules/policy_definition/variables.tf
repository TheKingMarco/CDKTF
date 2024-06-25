variable "target_resource_name" {
  description = "Name of the target resource to create the policy name (policy-<target_resource_name>-<policy_name>)"
}

variable "resource_id" {
  description = " (Required) The ID of the Resource (or Resource Scope) where this should be applied."
}

variable "parameters_policy" {
  description = "Parameters to apply the policy"
}

variable "enabled" {
  description = "parameter used to enable (true) or disable (false) the policy"
}

variable "policy_name" {
  description = "The name of the policy this must be unique"
}

variable "display_name" {
  description = "The display name of the azure policy"
}