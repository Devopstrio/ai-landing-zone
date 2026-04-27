# Devopstrio AI-LZ: Workload Identity Setup
# Eliminates Kubernetes Secrets for Cloud Access

resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "id-ai-plat-workload"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Grant Access to OpenAI for the Workload Identity
resource "azurerm_role_assignment" "oai_access" {
  scope                = var.openai_account_id
  role_definition_name = "Cognitive Services User"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

# Grant Access to Key Vault
resource "azurerm_role_assignment" "kv_access" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

output "workload_identity_client_id" {
  value = azurerm_user_assigned_identity.aks_identity.client_id
}
