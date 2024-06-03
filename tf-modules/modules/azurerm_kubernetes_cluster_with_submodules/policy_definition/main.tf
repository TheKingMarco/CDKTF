data "azurerm_policy_definition" "policy" {
  display_name = var.display_name
}


resource "azurerm_resource_policy_assignment" "policy-application" {
  count = var.enabled == true ? 1 : 0
  name                 = "policy-${var.aks-name}-${var.policy_name}"
  resource_id          = var.aks-cluster-id
  policy_definition_id = data.azurerm_policy_definition.policy.id
  parameters           = var.parameters-policy
}
