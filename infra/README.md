# Infra

Bicep-templates voor de Azure-resources van deze applicatie.

## Resourcegroep

```
rg-kb-<domein>-<applicatie>-<env>
```

Voor `env`: `dev`, `tst`, `prd`. Iedere omgeving in een eigen resourcegroep.

## Deployen

```bash
# Eerst inloggen op de juiste subscription
az login
az account set --subscription <kb-nonprod | kb-prod>

# Resourcegroep aanmaken (eenmalig per omgeving)
az group create \
  --name rg-kb-<domein>-<applicatie>-<env> \
  --location westeurope \
  --tags owner=<email> domain=<domein> environment=<env> \
         application=<naam> costcenter=<kwekerij|overhead|rd> \
         lifecycle=<poc|mvp|prod> dataclass=<internal|confidential|personal>

# Deployen
az deployment group create \
  --resource-group rg-kb-<domein>-<applicatie>-<env> \
  --template-file main.bicep \
  --parameters env=<env> applicationName=<naam> domain=<domein> \
               ownerEmail=<email> lifecycle=<poc|mvp|prod>
```

## Verplichte tags

Zie `docs/ai-coding-guidelines.md` hoofdstuk 3. De parameters van `main.bicep` dwingen deze tags af.
