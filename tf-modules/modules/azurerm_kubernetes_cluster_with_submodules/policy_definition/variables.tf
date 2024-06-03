variable "aks-name" {
  type        = string
  description = "Aks Cluster Name (used in the policy assignment name)"
}

variable "aks-cluster-id" {
  type = string
  description = "Aks Cluster Object ID (used to apply the policy)"
}

variable "parameters-policy" {
  description = "Parameters to apply the policy"
  # Note: the default value is defined in the main "ecs" module
}

variable "enabled" {
  
}

variable "policy_name" {
  
}

variable "display_name" {
  
}