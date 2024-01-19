locals {
  NAMING = {
    "RESOURCE_GROUP" = "rg-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "SUBNET"         = "sub-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "VNET"           = "vnet-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "NIC"            = "nic-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "PIP"            = "pip-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "VM"             = "vm-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "NSG"            = "nsg-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "STOR"           = "stor${var.WORKLOAD}${var.SUBSCRIPTION_TYPE}${var.AZURE_REGION}"
    "CI"             = "ci-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "CI_DNS_LABEL"   = "ci-dns-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
  }
  TAGS = {
    GENERAL = {
      "enviroment"   = lower(var.ENVIRONMENT),
      "region"       = lower(var.LOCATION)
      "subscription" = lower(var.SUBSCRIPTION_TYPE)
    }
  }
}