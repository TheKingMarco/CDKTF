output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config
}
output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}