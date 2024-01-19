resource "azurerm_container_group" "azure_container_instance" {
  for_each            = var.ACI
  name                = "${local.NAMING["CI"]}-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type     = var.ACI[each.key].ip_address_type
  dns_name_label      = "${local.NAMING["CI_DNS_LABEL"]}-${each.key}"
  os_type             = var.ACI[each.key].os_type

  dynamic "container" {
    for_each = var.ACI[each.key].container
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      dynamic "ports" {
        for_each = container.value.ports
        content {
          #port     = ports.value["port"]  #FUNZIONANTE
          #protocol = ports.value["protocol"] #FUNZIONANTE
          port     = lookup(ports.value, "port", null)     #FUNZIONANTE
          protocol = lookup(ports.value, "protocol", null) #FUNZIONANTE
        }
      }
      environment_variables = container.value.environment_variables
    }
  }
  # container { #FUNZIONANTE
  #   name   = var.ACI[each.key].container.name
  #   image  = var.ACI[each.key].container.image
  #   cpu    = var.ACI[each.key].container.cpu
  #   memory = var.ACI[each.key].container.memory

  #   dynamic "ports" {
  #     for_each = var.ACI[each.key].container.ports
  #     content {
  #       #port     = ports.value["port"]  #FUNZIONANTE
  #       #protocol = ports.value["protocol"] #FUNZIONANTE
  #       port = lookup(ports.value, "port", null) #FUNZIONANTE
  #       protocol = lookup(ports.value, "protocol", null) #FUNZIONANTE
  #     }
  #   }
  tags = local.TAGS["GENERAL"]
}


