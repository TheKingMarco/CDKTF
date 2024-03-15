LOCATION          = "westeurope"
ENVIRONMENT       = "noprod"
WORKLOAD          = "tf"
SUBSCRIPTION_TYPE = "eni"
AZURE_REGION      = "we"

AKS = {
  dns_prefix = "test"
  default_node_pool = {
    name       = "nodepool"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  identity = {
    type = "SystemAssigned"
  }
  nodes_pools = {
    "01" = {
      name       = "nodepool01"
      vm_size    = "Standard_D2_v2"
      node_count = 1
    },
    "02" = {
      name       = "nodepool02"
      vm_size    = "Standard_D2_v2"
      node_count = 1
    }
  }
}
