data "azurerm_log_analytics_workspace" "logwork" {
  name                = "testloganaworks"
  resource_group_name = "MARCO-RG"
}