# Devopstrio AI-LZ: High-Performance Isolated Storage
# Purpose: AI Training Data & Model Weights

resource "azurerm_storage_account" "datalake" {
  name                     = "stailzdatalakeprod"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  # Security Hardening
  public_network_access_enabled = false
  infrastructure_encryption_enabled = true
}

# Private Endpoint for Data Lake
resource "azurerm_private_endpoint" "st_pe" {
  name                = "pe-st-datalake"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_subnet_id

  private_service_connection {
    name                           = "psc-datalake"
    private_connection_resource_id = azurerm_storage_account.datalake.id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }
}
