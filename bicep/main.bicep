// Devopstrio AI Landing Zone: Master Bicep Template
// Architecture: Native Enterprise Infrastructure

targetScope = 'subscription'

param location string = 'uksouth'
param prefix string = 'ailz'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${prefix}-core-prod'
  location: location
}

// 1. Networking Module (Hub-Spoke)
module network './modules/network.bicep' = {
  scope: rg
  name: 'networkDeploy'
  params: {
    location: location
    vnetName: 'vnet-${prefix}-hub'
  }
}

// 2. Security Module (Key Vault / Defender)
module security './modules/security.bicep' = {
  scope: rg
  name: 'securityDeploy'
  params: {
    location: location
    vaultName: 'kv-${prefix}-prod'
  }
}

// 3. AI Core (Azure OpenAI)
module ai './modules/openai.bicep' = {
  scope: rg
  name: 'aiDeploy'
  params: {
    location: location
    accountName: 'oai-${prefix}-platform'
  }
}

output hubVNetId string = network.outputs.vnetId
