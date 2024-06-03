resource "azurerm_resource_group" "rg_main" {
  name     = local.NAMING["RG"]
  location = var.LOCATION
  tags     = local.TAGS["GENERAL"]
}

module "azurerm_kubernetes_cluster" {
  source = "../../../tf-modules/modules/azurerm_kubernetes_cluster_with_submodules"

  name                = local.NAMING["AKS"]
  location            = var.LOCATION
  dns_prefix          = local.NAMING["AKS_DNS"]
  identity            = var.AKS.identity
  default_node_pool   = var.AKS.default_node_pool
  resource_group_name = azurerm_resource_group.rg_main.name
  policy_definitions  = var.policy_definitions
  
  tags                = local.TAGS.GENERAL
}