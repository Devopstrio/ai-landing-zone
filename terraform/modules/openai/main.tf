# Devopstrio AI LZ: Secure OpenAI Service
# Mandatory: Private Link Enabled

resource "azurerm_cognitive_account" "openai" {
  name                = "oai-devopstrio-platform-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = "S0"

  # Secure Defaults
  public_network_access_enabled = false
  custom_subdomain_name         = "oai-devopstrio-platform"
}

# Private Endpoint for OpenAI
resource "azurerm_private_endpoint" "oai_pe" {
  name                = "pe-oai-platform"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.spoke_subnet_id

  private_service_connection {
    name                           = "psc-openai"
    private_connection_resource_id = azurerm_cognitive_account.openai.id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }
}

# Automated Deployment (GPT-4o)
resource "azurerm_cognitive_deployment" "gpt4o" {
  name                 = "gpt-4o-enterprise"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-05-13"
  }
  scale {
    type = "Standard"
  }
}
