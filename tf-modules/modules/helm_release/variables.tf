variable "name" {
  type = string
}
variable "repository" {
  type = string
}
variable "chart" {
  type = string
}
variable "chart_version" {
  type = string
  default = null
}
variable "namespace" {
  type = string
  default = null
}
variable "create_namespace" {
  type = bool
  default = null
}
variable "values" {
  type = list(string)
  default = null
}
variable "description" {
  type = string
  default = null
}
variable "set" {
  type = set(object({
    name = string
    value = any
    type = string
  }))
  default = [ {
    name = ""
    value = ""
    type = null
  } ]
}
variable "set_list" {
  type = list(object({
    name = string
    value = list(string)
  }))
  default = [ {
    name = ""
    value = [""]
  } ]
}
variable "set_sensitive" {
  type = set(object({
    name = string
    value = any
    type = string
  }))
  default = [ {
    name = ""
    value = ""
    type = null
  } ]
}