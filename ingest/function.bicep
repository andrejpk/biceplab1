param resourcePrefix string

var location = resourceGroup().location
var extendedPrefix = '${resourcePrefix}${uniqueString(resourceGroup().id)}'

resource ingestFn 'Microsoft.Web/sites@2020-12-01' = {
  name: '${extendedPrefix}fn'
  location: location
  properties: {
    serverFarmId: functionApp.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.outputs.ikey
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: '$InstrumentationKey=${appInsights.outputs.ikey}'
        }
      ]
    }
  }
}

resource functionApp 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: '${extendedPrefix}webapp'
  location: location
}

module appInsights 'ai.bicep' = {
  name: 'ai'
  params: {
    extendedPrefix: extendedPrefix
    location: location
  }
}
