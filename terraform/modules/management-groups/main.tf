# Devopstrio AI Landing Zone: Management Group Hierarchy
# Implementation of Enterprise Cloud Architecture

resource "azurerm_management_group" "root" {
  display_name = "Devopstrio Enterprise AI"
  name         = "mg-devopstrio-root"
}

resource "azurerm_management_group" "platform" {
  display_name               = "Platform Services"
  name                       = "mg-devopstrio-platform"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "workloads" {
  display_name               = "AI Workloads"
  name                       = "mg-devopstrio-workloads"
  parent_management_group_id = azurerm_management_group.root.id
}

# Automated Policy Assignment: Security Guardrails
resource "azurerm_management_group_policy_assignment" "secure_ai" {
  name                 = "EnforceSecureAI"
  management_group_id  = azurerm_management_group.root.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56961ad-ca93-4042-818b-590fb6ef9a87" # Standard Locate
  display_name         = "Enforce AI Regional Compliance"
}

output "root_mg_id" {
  value = azurerm_management_group.root.id
}
