resource "azurerm_resource_group" "rg-main" {
  name     = local.NAMING["RG"]
  location = var.LOCATION
}