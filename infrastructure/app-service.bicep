@description('Workload name')
param workload string

@description('Environment name')
param environment string

@description('Region for all resources in this module')
param location string

@description('Resource Tags')
param tags object = {}

@description('Runtime stack')
param linuxFxVersion string = 'NODE|20-lts'

@description('App Service Subnet Id')
param appServiceSubnetId string

@description('Private Endpoint Subnet Id')
param privateEndpointSubnetId string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'asp-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: 'F1'
  }
  kind: 'linux'
}

@description('An App service to run the app')
resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: 'app-fbitn-${workload}-${environment}-${location}-01'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
    virtualNetworkSubnetId: appServiceSubnetId
    publicNetworkAccess: 'Disabled'
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      publicNetworkAccess: 'Disabled' // important to disable this or the deployment wont go through in corp subscriptions.
      ftpsState: 'FtpsOnly'
      appSettings:[
        {
          name: 'SCM_MAX_ZIP_PACKAGE_COUNT'
          value: '1' // keeping only the recent zip uploaded to app service
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'SCM_MAX_ZIP_PACKAGE_COUNT'
          value: '1' // keeping only the recent zip uploaded to app service
        }
      ]
    }
  }
}


@description('A private endpoint to make the App accessible within the virtual network')
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: 'pep-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'plconnection-${workload}-${environment}'
        properties: {
          privateLinkServiceId: appService.id
          groupIds: [
            'sites'
          ]
        }
      }
    ]
  }
}

output appService object = appService
