variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "ip_address_type" {
  type = string
  default = null
}
variable "dns_name_label" {
}
variable "os_type" {
}
variable "container" {
    type = list(object({
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
}
variable "tags" {
}

