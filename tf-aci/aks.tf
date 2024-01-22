resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.NAMING["AKS"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.AKS.dns_prefix

  default_node_pool {
    name       = var.AKS.default_node_pool.name
    node_count = var.AKS.default_node_pool.node_count
    vm_size    = var.AKS.default_node_pool.vm_size
  }

  identity {
    type = var.AKS.identity.type
  }

  tags = local.TAGS.GENERAL
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_nodepool" {
  for_each              = var.AKS.nodes_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count

  tags = local.TAGS.GENERAL
}