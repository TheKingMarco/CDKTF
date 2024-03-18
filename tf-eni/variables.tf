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
# AKS
############
variable "AKS" {}
############
# HELM
############
variable "HELM_RELEASE" {}