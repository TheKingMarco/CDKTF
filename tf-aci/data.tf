data "azurerm_resource_group" "rg" {
  name = "Avanade-RG"
}

data "azurerm_virtual_network" "vnet" {
  name                = "Avanade-Vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}