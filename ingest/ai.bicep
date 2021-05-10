param extendedPrefix string
param location string

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: '${extendedPrefix}ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

output ai object = appInsights
output ikey string = appInsights.properties.InstrumentationKey
