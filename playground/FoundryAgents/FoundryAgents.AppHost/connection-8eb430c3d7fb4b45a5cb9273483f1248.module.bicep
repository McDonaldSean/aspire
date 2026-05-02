@description('The location for the resource(s) to be deployed.')
param location string = resourceGroup().location

param proj_myproject_outputs_name string

param search_outputs_name string

resource proj_myproject 'Microsoft.CognitiveServices/accounts/projects@2025-09-01' existing = {
  name: proj_myproject_outputs_name
}

resource search 'Microsoft.Search/searchServices@2023-11-01' existing = {
  name: search_outputs_name
}

resource connection_8eb430c3d7fb4b45a5cb9273483f1248 'Microsoft.CognitiveServices/accounts/projects/connections@2026-03-01' = {
  name: 'connection-8eb430c3d7fb4b45a5cb9273483f1248'
  properties: {
    category: 'CognitiveSearch'
    metadata: {
      ApiType: 'Azure'
      ResourceId: search.id
      location: search.location
    }
    target: 'https://${search_outputs_name}.search.windows.net'
    authType: 'AAD'
  }
  parent: proj_myproject
}

output name string = 'connection-8eb430c3d7fb4b45a5cb9273483f1248'

output id string = connection_8eb430c3d7fb4b45a5cb9273483f1248.id