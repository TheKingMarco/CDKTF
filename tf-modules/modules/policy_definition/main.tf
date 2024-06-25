data "azurerm_policy_definition" "policy_definition" {
  display_name = var.display_name
}


resource "azurerm_resource_policy_assignment" "policy_assignment" {
  count = var.enabled == true ? 1 : 0
  name                 = "policy-${var.target_resource_name}-${var.policy_name}"
  resource_id          = var.resource_id
  policy_definition_id = data.azurerm_policy_definition.policy_definition.id
  parameters           = var.parameters_policy
}
