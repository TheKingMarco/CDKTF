resource "azurerm_resource_group" "rg_main" {
  name     = local.NAMING["RG"]
  location = var.LOCATION
  tags     = local.TAGS["GENERAL"]
}

module "azurerm_kubernetes_cluster" {
  source = "../../../tf-modules/modules/azurerm_kubernetes_cluster"

  name                = local.NAMING["AKS"]
  location            = var.LOCATION
  dns_prefix          = local.NAMING["AKS_DNS"]
  identity            = var.AKS.identity
  default_node_pool   = var.AKS.default_node_pool
  resource_group_name = azurerm_resource_group.rg_main.name

  tags = local.TAGS.GENERAL
}

module "policy_definition" {
  for_each = var.policy_definitions == null ? {} : var.policy_definitions
  source = "../../../tf-modules/modules/policy_definition"
  resource_id = module.azurerm_kubernetes_cluster.aks_id
  target_resource_name = var.target_resource_name
  display_name = each.value.display_name
  enabled = each.value.enabled
  policy_name = each.value.policy_name
  parameters_policy = each.value.parameters_policy
}