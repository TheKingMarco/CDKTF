locals {
  NAMING = {
    "RG"           = "rg-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "SUBNET"       = "sub-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "VNET"         = "vnet-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "NIC"          = "nic-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "PIP"          = "pip-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "VM"           = "vm-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "NSG"          = "nsg-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "STOR"         = "stor${var.ENVIRONMENT}${var.WORKLOAD}${var.SUBSCRIPTION_TYPE}${var.AZURE_REGION}"
    "CI"           = "ci-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "CI_DNS_LABEL" = "ci-dns-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "AKS"          = "aks-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "KV"           = "kv-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "PRIVATE-SC"   = "psc-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
    "PE"           = "pe-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}" 
    "AKS_DNS"      = "aks-dns-${var.ENVIRONMENT}-${var.WORKLOAD}-${var.SUBSCRIPTION_TYPE}-${var.AZURE_REGION}"
  }
  TAGS = {
    GENERAL = {
      "enviroment"   = lower(var.ENVIRONMENT),
      "region"       = lower(var.LOCATION)
      "subscription" = lower(var.SUBSCRIPTION_TYPE)
    }
  }
}