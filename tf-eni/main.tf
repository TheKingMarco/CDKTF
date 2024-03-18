resource "azurerm_resource_group" "rg_main" {
  name     = local.NAMING["RG"]
  location = var.LOCATION
  tags     = local.TAGS["GENERAL"]
}

module "azurerm_kubernetes_cluster" {
  source = "github.com/TheKingMarco/Learn-Terraform.git//tf-modules/modules/azurerm_kubernetes_cluster"

  name                = local.NAMING["AKS"]
  location            = var.LOCATION
  dns_prefix          = local.NAMING["AKS_DNS"]
  identity            = var.AKS.identity
  default_node_pool   = var.AKS.default_node_pool
  nodes_pools         = var.AKS.nodes_pools
  resource_group_name = azurerm_resource_group.rg_main.name
  tags                = local.TAGS.GENERAL
}

resource "azurerm_public_ip" "pip" {
  name                = "gitlabpip"
  resource_group_name = module.azurerm_kubernetes_cluster.node_resource_group
  location            = var.LOCATION
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "helm_release" {
  #source           = "./modules/helm_release"
  source           = "github.com/TheKingMarco/Learn-Terraform.git//tf-modules/modules/helm_release"
  for_each         = var.HELM_RELEASE
  name             = var.HELM_RELEASE[each.key].name
  repository       = var.HELM_RELEASE[each.key].repository
  chart            = var.HELM_RELEASE[each.key].chart
  chart_version    = var.HELM_RELEASE[each.key].chart_version
  namespace        = var.HELM_RELEASE[each.key].namespace
  create_namespace = var.HELM_RELEASE[each.key].create_namespace
  timeout          = var.HELM_RELEASE[each.key].timeout
  values           = var.HELM_RELEASE[each.key].values
  set = [{
    name  = "global.hosts.externalIP"
    value = "${azurerm_public_ip.pip.ip_address}"
  }]
  depends_on = [module.azurerm_kubernetes_cluster]
}