resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size
        temporary_name_for_rotation = var.default_node_pool.temporary_name_for_rotation
  }

  identity {
    type = var.identity.type
  }

  

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_nodepool" {
  for_each              = var.nodes_pools == null ? {} : var.nodes_pools
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count

  tags = var.tags
}