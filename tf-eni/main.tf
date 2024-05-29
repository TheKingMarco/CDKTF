resource "azurerm_resource_group" "rg_main" {
  name     = local.NAMING["RG"]
  location = var.LOCATION
  tags     = local.TAGS["GENERAL"]
}

module "azurerm_kubernetes_cluster" {
  source = "../tf-modules/modules/azurerm_kubernetes_cluster"

  name                = local.NAMING["AKS"]
  location            = var.LOCATION
  dns_prefix          = local.NAMING["AKS_DNS"]
  identity            = var.AKS.identity
  default_node_pool   = var.AKS.default_node_pool
  # nodes_pools         = var.AKS.nodes_pools
  resource_group_name = azurerm_resource_group.rg_main.name
  
  tags                = local.TAGS.GENERAL
}

# module "helm_release_ingress_nginx" {
#   source           = "../tf-modules/modules/helm_release"

#   name             = var.HELM_RELEASE["ingress-nginx"].name
#   repository       = var.HELM_RELEASE["ingress-nginx"].repository
#   chart            = var.HELM_RELEASE["ingress-nginx"].chart
#   chart_version    = var.HELM_RELEASE["ingress-nginx"].chart_version
#   namespace        = var.HELM_RELEASE["ingress-nginx"].namespace
#   create_namespace = var.HELM_RELEASE["ingress-nginx"].create_namespace
#   timeout          = var.HELM_RELEASE["ingress-nginx"].timeout
#   values           = var.HELM_RELEASE["ingress-nginx"].values

#   depends_on = [module.azurerm_kubernetes_cluster]
# }

#  tutto il modulo gitlab funziona correttamente , sto commentando per una questione di costi, deccommenta quando devi fare dei test
#  sto anche scalando i nodi a uno e diminuendo lo sku (in caso riportali allo stato precedente)
# resource "azurerm_public_ip" "pip" {
#   name                = "gitlabpip"
#   resource_group_name = module.azurerm_kubernetes_cluster.node_resource_group
#   location            = var.LOCATION
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# module "helm_release_gitlab" {
#   source           = "../tf-modules/modules/helm_release"

#   name             = var.HELM_RELEASE["gitlab"].name
#   repository       = var.HELM_RELEASE["gitlab"].repository
#   chart            = var.HELM_RELEASE["gitlab"].chart
#   chart_version    = var.HELM_RELEASE["gitlab"].chart_version
#   namespace        = var.HELM_RELEASE["gitlab"].namespace
#   create_namespace = var.HELM_RELEASE["gitlab"].create_namespace
#   timeout          = var.HELM_RELEASE["gitlab"].timeout
#   values           = var.HELM_RELEASE["gitlab"].values
#   set =  [{
#     name  = "global.hosts.externalIP"
#     value = "${azurerm_public_ip.pip.ip_address}"
#   }]
#   depends_on = [module.azurerm_kubernetes_cluster]
# }


