resource "helm_release" "release" {
  name       = var.name 
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version
  namespace = var.namespace
  create_namespace = var.create_namespace
  description = var.description

  values = var.values


  dynamic "set" {
    for_each = var.set
    content {
      name = set.value.name
      value = set.value.value
      type = set.value.type
    }
  }

  dynamic "set_list" {
    for_each = var.set_list
    content {
      name = set_list.value.name
      value = set_list.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive
    content {
      name = set_sensitive.value.name
      value = set_sensitive.value.value
      type = set_sensitive.value.type
    }
  }

}