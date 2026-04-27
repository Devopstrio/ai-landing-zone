# Devopstrio AI-LZ: Unified Observability Module
# Architecture: Log Analytics + Application Insights

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-ai-emm-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "app_insights" {
  name                = "appi-ai-emm-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.law.id
  application_type    = "web"
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "instrumentation_key" {
  value     = azurerm_application_insights.app_insights.instrumentation_key
  sensitive = true
}
