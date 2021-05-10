targetScope = 'subscription'

param location string
param resourcePrefix string

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'rg_main'
  location: location
}

module ingestStrorage 'ingest/IngestStorage.bicep' = {
  name: 'ingestStorage'
  params: {
    location: location
    resourcePrefix: resourcePrefix
  }
  scope: rg
}

module ingestFn 'ingest/function.bicep' = {
  name: 'ingestFn'
  params: {
    resourcePrefix: resourcePrefix
  }
  scope: rg
}

var url = ingestStrorage.outputs.urls
