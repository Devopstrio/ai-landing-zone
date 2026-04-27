# Devopstrio AI Landing Zone: Hub-and-Spoke Orchestration
# Architecture: Zero-Trust Network Foundation

resource "azurerm_resource_group" "hub" {
  name     = "rg-ailz-hub-prod"
  location = var.location
}

# 1. Hub VNet (Central Connectivity)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-ailz-hub-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}

# 2. Azure Firewall for Egress Inspection
resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 3. Spoke VNet (AI Workload Subnet)
resource "azurerm_resource_group" "spoke" {
  name     = "rg-ailz-spoke-ai"
  location = var.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "vnet-ailz-spoke-ai-01"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
}

# 4. Networking Peering (Bi-Directional)
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub"
  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}
