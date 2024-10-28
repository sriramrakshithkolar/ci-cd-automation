@description('Environment name')
@allowed([
  'dev'
  'uat'
  'qa'
  'prd'
])
param environment string

var environmentConfigurationMap = {
  dev: {
    monitorable: 'N' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    appServiceVnet: {  // App service VNet integration settings
      resoureGroupName: 'rg-ci-cd-automation-dev'
      virtualNetworkName: 'vnet-development-eastus2-01'
      subnetName: 'snet-development-appservice-eastus2-01'
    }
    alerts: {
      contactEmails: [
        {
          name: 'Sriram Rakshith Kolar'
          emailAddress: 'sriramrakshithkolar@gmail.com'
        }
      ]
    }
  }
}

output settings object = environmentConfigurationMap[environment]
