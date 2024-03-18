provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.azurerm_kubernetes_cluster.kube_config.0.host
    client_certificate     = base64decode(module.azurerm_kubernetes_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(module.azurerm_kubernetes_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.azurerm_kubernetes_cluster.kube_config.0.cluster_ca_certificate)
  }
}