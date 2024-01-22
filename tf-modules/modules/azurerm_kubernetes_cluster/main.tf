resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = var.identity.type
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_nodepool" {
  for_each = var.nodes_pools
  name                  = var.nodes_pools.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.nodes_pools.vm_size
  node_count            = var.nodes_pools.node_count

  tags = var.tags
}