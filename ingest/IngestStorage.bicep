@minLength(3)
@maxLength(11)
param resourcePrefix string

param location string

resource storage 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(0,3): {
  name: '${resourcePrefix}ingeststorage${i}'
  kind: 'BlobStorage'
  location: location
  sku: {
    name: 'Premium_LRS'
  }
}]

output urls array = [for i in range(0,3): storage[i].properties.primaryEndpoints.blob]
