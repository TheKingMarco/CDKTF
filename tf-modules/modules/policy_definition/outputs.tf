output "policy_id" {
  value = azurerm_resource_policy_assignment.policy_assignment[0].id
  description = "Exported policy id (resource)"
}

output "policy_name" {
  value = azurerm_resource_policy_assignment.policy_assignment[0].name
  description = "Exported policy id (resource)"
}