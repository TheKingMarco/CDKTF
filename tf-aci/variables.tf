###################################
# TENANT AND SUBSCRIPTION VARIABLES
###################################
variable "LOCATION" {
  type = string
}
variable "ENVIRONMENT" {
  type    = string
  default = ""
}
##############################################
# NAMING CONVENTIONS VARIABLES - DO NOT CHANGE
##############################################
variable "WORKLOAD" {
  description = "Worload Name"
  type        = string
  default     = ""
}
variable "SUBSCRIPTION_TYPE" {
  description = "Subscription Type"
  type        = string
  default     = ""
}
variable "AZURE_REGION" {
  description = "Azure Region"
  type        = string
  default     = ""
}
############
# NETWORKING
############

############
# ACI
############
variable "ACI" {
  #type = map(any)
  type = map(object({
    ip_address_type = string
    os_type         = string
    container = list(object({
      name   = string
      image  = string
      cpu    = string
      memory = string
      ports = list(object({
        port     = number
        protocol = string
      }))
      environment_variables = map(any)
    }))
  }))
  default = {
    "aci_1" = {
      ip_address_type = "value"
      os_type         = "value"
      container = [{
        cpu    = "value"
        image  = "value"
        memory = "value"
        name   = "value"
        ports = [
          {
            port     = 80
            protocol = "TCP"
          },
          {
            port     = 8080
            protocol = "TCP"
        }]
        environment_variables = {
          test = "test"
        }
      }]
    }
  }
}

variable "AKS" {
  type = object({
    dns_prefix = string
    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })
    identity = object({
      type = string
    })
    nodes_pools = map(object({
      name       = string
      vm_size    = string
      node_count = number
    }))
  })
}