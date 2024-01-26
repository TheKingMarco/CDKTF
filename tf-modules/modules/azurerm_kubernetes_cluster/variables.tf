variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "dns_prefix" {
  type    = string
  default = null
}
variable "kubernetes_version" {
  type    = string
  default = null
}
variable "network_profile" {
  type    = string
  default = null
}
variable "default_node_pool" {
  type = object({
    name       = string
    vm_size    = string
    node_count = number
    temporary_name_for_rotation = optional(string, null)
  })
}
variable "identity" {
  type = object({
    type = string
  })
}
variable "tags" {
  type = map(any)
}
variable "nodes_pools" {
  type = map(object({
    name       = string
    vm_size    = string
    node_count = number
  }))
}