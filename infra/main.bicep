// Voorbeeld Bicep-template voor een nieuwe applicatie.
// Pas naam, dependencies en resources aan; behoud de tags-structuur.
//
// Deploy:
//   az deployment group create \
//     --resource-group rg-kb-<domein>-<applicatie>-<env> \
//     --template-file main.bicep \
//     --parameters env=dev applicationName=<naam>

@description('De omgeving waarin gedeployed wordt.')
@allowed(['dev', 'tst', 'prd'])
param env string

@description('Applicatienaam zonder kb-domein-prefix.')
param applicationName string

@description('Domein waaronder deze applicatie valt.')
@allowed(['verkoop', 'inkoop', 'finance', 'hr', 'logistiek', 'productie', 'data', 'platform'])
param domain string

@description('Applicatie-eigenaar (e-mail).')
param ownerEmail string

@description('Costcenter voor toerekening.')
@allowed(['kwekerij', 'overhead', 'rd'])
param costcenter string = 'kwekerij'

@description('Lifecycle-fase van deze applicatie.')
@allowed(['poc', 'mvp', 'prod', 'sunset'])
param lifecycle string

@description('Dataclassificatie.')
@allowed(['public', 'internal', 'confidential', 'personal'])
param dataclass string = 'internal'

@description('Locatie voor alle resources.')
param location string = 'westeurope'

// === Verplichte tags voor iedere resource ===
var commonTags = {
  owner: ownerEmail
  domain: domain
  environment: env
  application: applicationName
  costcenter: costcenter
  lifecycle: lifecycle
  dataclass: dataclass
}

// === Naam-helpers ===
var resourcePrefix = 'kb-${domain}-${applicationName}'

// === Voorbeeld: Log Analytics workspace (verwijs liefst naar centrale workspace) ===
// resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
//   name: 'log-kb-shared-${env}'
//   scope: resourceGroup('rg-kb-platform-shared-${env}')
// }

// === Voorbeeld: Application Insights ===
// resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
//   name: 'appi-${resourcePrefix}-${env}'
//   location: location
//   kind: 'web'
//   tags: commonTags
//   properties: {
//     Application_Type: 'web'
//     WorkspaceResourceId: logAnalytics.id
//   }
// }

// === Voorbeeld: Container App ===
// resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
//   name: 'ca-${resourcePrefix}-${env}'
//   location: location
//   tags: commonTags
//   identity: {
//     type: 'SystemAssigned'  // Managed Identity, conform richtlijnen
//   }
//   properties: {
//     // ...
//   }
// }

output resourcePrefix string = resourcePrefix
output tags object = commonTags
