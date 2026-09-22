# Runbook — kb-<domein>-<applicatie>

> Voor PoC niet verplicht. Voor MVP basis-invulling. Voor productie volledig.

## Wat doet deze applicatie?

<!-- Eén alinea: wat doet het, waar draait het, welke gebruikers raken het kwijt als het stuk is. -->

## Wie bellen bij een storing?

| Tijdvenster | Wie | Contact |
|---|---|---|
| Kantooruren | Applicatie-eigenaar | <e-mail / telefoon> |
| Buiten kantoor | Plaatsvervanger | <e-mail / telefoon> |
| Bij Azure-problemen | Azure-beheerder | <e-mail> |

## Waar vind je wat?

- **Repository:** <link>
- **Azure resourcegroep prd:** `rg-kb-<domein>-<applicatie>-prd`
- **Logs:** Application Insights — werkruimte `<naam>`, applicatie `kb-<domein>-<applicatie>`
- **Secrets:** Key Vault `<naam>`
- **Documentatie:** `docs/`

## Vaakvoorkomende problemen

### Symptoom: <bijv. app reageert niet>

**Mogelijke oorzaak 1:** <…>
**Controle:** <commando of stap>
**Oplossing:** <stap>

### Symptoom: <…>

<!-- Vul aan naarmate problemen zich voordoen. -->

## Hoe doe ik een rollback?

<!-- Concrete stappen. Bijvoorbeeld: deploy vorige container image tag via GitHub Actions, of via Azure Portal. -->

## Hoe verifieer ik dat het weer werkt?

<!-- Smoke test: één of twee acties die je doet om zeker te weten dat de hoofdfunctie werkt. -->

## Geteste recovery (productie verplicht)

- **Laatste test op:** <datum>
- **Door:** <naam>
- **Resultaat:** <slagen / falen + opmerkingen>
