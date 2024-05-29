LOCATION          = "italynorth"
ENVIRONMENT       = "noprod"
WORKLOAD          = "tf"
SUBSCRIPTION_TYPE = "eni"
AZURE_REGION      = "ita"

AKS = {
  default_node_pool = {
    name       = "nodepool"
    node_count = 1
    vm_size    = "Standard_B2s" #Standard_B2s
    temporary_name_for_rotation = "rotation"
  }
  identity = {
    type = "SystemAssigned"
  }
  # nodes_pools = {
  #   "01" = {
  #     name       = "nodepool01"
  #     vm_size    = "Standard_D2_v2"
  #     node_count = 1
  #   },
  #   "02" = {
  #     name       = "nodepool02"
  #     vm_size    = "Standard_D2_v2"
  #     node_count = 1
  #   }
  # }
}


HELM_RELEASE = {
  "gitlab" = {
    name             = "gitlab"
    repository       = "http://charts.gitlab.io/"
    chart            = "gitlab"
    chart_version    = "7.8.0"
    namespace        = "gitlab"
    create_namespace = true
    timeout          = 600
    values           = ["helm_values/gitlab_values.yaml"]
  }
  "ingress-nginx" = {
    name             = "ingress-nginx"
    repository       = "https://kubernetes.github.io/ingress-nginx/"
    chart            = "ingress-nginx"
    chart_version    = "4.10.0"
    namespace        = "ingress-nginx"
    create_namespace = true
    timeout          = 600
    values           = []
  }
}