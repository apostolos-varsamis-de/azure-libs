targetScope = 'subscription'

param location string
param tags object = {}

var resourceGroup = 'azure-oc-DataEngineering'
var acrName = 'ocdemoregistry'

// Set up the resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroup
  location: location
  tags: tags
}

// Set up the container registry
module acr 'bicep/modules/azure-container-registry/main.bicep' = {
  scope: rg
  name: 'acrDeploy'
  params: {
    name: acrName
    location: location
    tags: tags
    sku: 'Basic'
    managedIdentityType: 'SystemAssigned'
  }
}
