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

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'asp-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: 'F1'
    capacity: 1
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
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      ftpsState: 'FtpsOnly'
      appSettings: [
        {
          name: 'SCM_MAX_ZIP_PACKAGE_COUNT'
          value: '1' // keeping only the recent zip uploaded to app service
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
      ]
    }
  }
}

output appService object = appService
