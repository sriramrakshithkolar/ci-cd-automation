@description('Workload name abbreviation')
param workload string

@description('Environment name abbreviation')
param environment string

@description('Resource Group location')
param location string = resourceGroup().location

@description('Deployment Identity name')
param deploymentIdentity string

@description('A module that defines all the environment specific configuration')
module configModule 'configuration.bicep' = {
  name: '${resourceGroup().name}-config-module'
  scope: resourceGroup()
  params: {
    environment: environment
  }
}

@description('A variable to hold all environment specific variables')
var config = configModule.outputs.settings

@description('The tags to be added for this workload')
var tags = {
  Workload: workload
  Environment: environment
  DeploymentIdentity: deploymentIdentity
  Monitorable: config.monitorable
}

@description('Obtaining reference to the subnet for App Service virtual network integration ')
resource appServiceSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name: '${config.appServiceVnet.virtualNetworkName}/${config.appServiceVnet.subnetName}'
  scope: resourceGroup(config.appServiceVnet.resoureGroupName)
}

@description('Obtaining reference to the virtual network subnet for the private endpoint')
resource privateEndpointSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name: '${config.appServiceVnet.virtualNetworkName}/${config.appServiceVnet.subnetName}'
  scope: resourceGroup(config.appServiceVnet.resoureGroupName)
}

@description('A module for the App Service resources')
module appServiceModule 'app-service.bicep' = {
  name: '${resourceGroup().name}-app-service-module'
  scope: resourceGroup()
  params: {
    workload: workload
    environment: environment
    location: location
    appServiceSubnetId: appServiceSubnet.id
    privateEndpointSubnetId: privateEndpointSubnet.id
    tags: tags
  }
}

