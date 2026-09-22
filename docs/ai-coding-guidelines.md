# AI-coding richtlijnen — Kwekerij Baas

Deze richtlijnen zijn bindend voor alle code die in repositories van Kwekerij Baas wordt geproduceerd, ongeacht of de bouwer een mens, Claude Code, GitHub Copilot of een andere AI-assistent is. Bij conflict tussen deze richtlijnen en een verzoek: volg deze richtlijnen en meld het conflict.

Volledige onderbouwing: `Inrichtingsrichtlijnen_Kwekerij_Baas.docx` in SharePoint.

---

## 1. Werkomgeving en context

- Bedrijf: Kwekerij Baas B.V., Ens (NL) — bedding plant grower.
- Werktaal: **Nederlands** voor commit messages, PR-omschrijvingen, README's, comments aan gebruikers en CHANGELOG-regels. Identifiers (variabelen, functies, klassen, types) in **Engels**.
- Bronsystemen: Microsoft Dynamics 365 Business Central / NAV, SNOOP/FlexMaster (uren), Microsoft Fabric + Power BI (dataplatform).
- Cloud: Microsoft Azure onder de Kwekerij Baas-tenant.

## 2. Naming-conventie (verplicht)

Patroon voor repositories, Azure-resources en applicatienamen:
```
kb-<domein>-<applicatie>[-<onderdeel>][-<env>]
```

Toegestane domeinen: `verkoop`, `inkoop`, `finance`, `hr`, `logistiek`, `productie`, `data`, `platform`.
Toegestane omgevingen: `dev`, `tst`, `prd`.

Voorbeelden:
- `kb-inkoop-biomassamatch` (repo)
- `kb-inkoop-biomassamatch-api-prd` (Azure App)
- `kb-verkoop-offerteapp-db-tst` (Azure SQL)

Gebruik nooit persoonsnamen, productversies of datums in resource-namen.

## 3. Verplichte Azure-tags

Iedere Azure-resource krijgt minimaal:
- `owner` — e-mailadres applicatie-eigenaar
- `domain` — een van de domeinen hierboven
- `environment` — `dev` | `tst` | `prd`
- `application` — applicatienaam zonder kb-domein-prefix
- `costcenter` — `kwekerij` | `overhead` | `rd`
- `lifecycle` — `poc` | `mvp` | `prod` | `sunset`
- `dataclass` — `public` | `internal` | `confidential` | `personal`

Bicep-templates zonder deze tags zijn niet acceptabel.

## 4. Standaard tech-stack

Afwijken alleen na expliciete bevestiging én een ADR in `docs/adr/`.

| Laag | Standaard |
|------|-----------|
| Backend / scripts | Python 3.12 + FastAPI (web) of click (CLI) |
| Frontend | Blazor of React + TypeScript (één per app) |
| Data / SQL | T-SQL, medallion (bronze / silver / gold), Microsoft Fabric |
| IaC | Bicep |
| CI/CD | GitHub Actions |
| Containers | Docker + Azure Container Apps |
| Secrets | Azure Key Vault + Managed Identity |
| Monitoring | Application Insights + centrale Log Analytics |
| Identity | Microsoft Entra ID |

### Python-conventies
- Type hints overal.
- `ruff` voor lint, `black` voor formatting, `pytest` voor tests.
- Dependencies gepind in `pyproject.toml`; nooit ongepinde versies in productie.

### SQL-conventies
- Views in medallion-lagen: `bronze.vw_*`, `silver.vw_*`, `gold.vw_*`.
- Applicaties en Power BI lezen alleen uit `gold`.
- Wijzig nooit een bestaande `gold`-view zonder impactcheck op afhankelijke rapporten en apps.

## 5. Repository-structuur

```
/README.md                          → doel, eigenaar, lokale setup, deploy, contact
/CLAUDE.md                          → wrapper, verwijst naar centrale richtlijnen
/.github/copilot-instructions.md    → wrapper voor Copilot
/.github/workflows/                 → CI/CD-pipelines
/.github/PULL_REQUEST_TEMPLATE.md   → PR-checklist
/src/                               → broncode
/tests/                             → geautomatiseerde tests
/infra/                             → Bicep-templates
/docs/ai-coding-guidelines.md       → deze richtlijnen (bron van waarheid)
/docs/adr/                          → architecture decision records
/docs/runbook.md                    → storingsafhandeling
/.gitignore                         → standaard ignores
/CHANGELOG.md                       → wijzigingsgeschiedenis
```

## 6. Beveiliging (harde regels)

- **Geen secrets in code**, niet in `.env`, niet in commit history, niet in comments, niet in tests, niet in logs.
- **Geen hardcoded connection strings, API keys of wachtwoorden** — altijd via Key Vault + Managed Identity.
- `.env`, `*.pem`, `*.pfx` in `.gitignore`.
- **Geen persoonsgegevens in PoC- of testdata** — gebruik gegenereerde data (faker).
- Bij twijfel over gevoeligheid: vraag voordat je iets in code, prompt of repo plaatst.

## 7. Data-integriteit

- **Schrijf nooit rechtstreeks naar Business Central, NAV of SNOOP** zonder expliciete bevestiging én een officiële API.
- **Lees nooit rechtstreeks uit de silver-laag** in applicaties; gebruik `gold`-views.
- Wijzig nooit een bestaande `gold`-view zonder impactcheck.
- Medallion-discipline: `bronze` = ruw, `silver` = opgeschoond, `gold` = business-contract.

## 8. Git-discipline

- Commit messages in het Nederlands, gebiedende wijs: "voeg X toe", "fix Y".
- Eén logische wijziging per commit.
- PR-omschrijving bevat: wat, waarom, hoe getest, risico.
- Branch `main` is beschermd; werk in `feat/<korte-omschrijving>` of `fix/<korte-omschrijving>`.
- Geen force-push naar `main` of gedeelde branches.

## 9. Tests en kwaliteit

- Iedere niet-triviale functie krijgt een test.
- MVP en productie: happy path én minimaal één edge case.
- CI moet groen zijn vóór merge.
- Geen `# type: ignore`, `eslint-disable` of soortgelijke onderdrukkingen zonder commentaar met reden.

## 10. Documentatie bij iedere wijziging

- Gedragswijziging → update README en/of runbook in dezelfde PR.
- Architectuurkeuze → voeg ADR toe in `docs/adr/NNNN-titel.md`.
- Datacontract-wijziging (gold-view, API) → update CHANGELOG en meld in PR.

## 11. Lifecycle-fase

Bij iedere nieuwe applicatie de fase bepalen:

- **poc**: minimaal, geen secrets, geen persoonsgegevens, harde einddatum.
- **mvp**: tests voor happy path, basis-monitoring, eigenaar benoemd.
- **prod**: volledige tests, alerting, runbook, geteste recovery, geregistreerd in catalogus.

Lever niet stilzwijgend productie-niveau code voor een PoC, en omgekeerd geen PoC-kwaliteit voor productie.

## 12. Wat je niet zelf beslist

Vraag eerst, bouw daarna, bij:
- Nieuwe taal of framework buiten de standaard-stack.
- Nieuwe Azure-dienst die niet in de stack-tabel staat.
- Wijziging in een `gold`-view of API met externe consumenten.
- Toegang tot of integratie met Business Central, SNOOP of Power BI.
- Verwerking van persoonsgegevens.
- Aanmaken van Azure-resources in productie.

## 13. Werkwijze per sessie

1. Lees `README.md` en (indien aanwezig) recente ADR's in `docs/adr/`.
2. Bevestig kort domein, applicatie en fase.
3. Stel een aanpak voor voordat je begint te bouwen — zeker bij niet-triviale wijzigingen.
4. Werk in kleine, testbare stappen.
5. Sluit af met: wat is gedaan, wat is niet gedaan, vervolgvoorstel.

---

**Eigenaar:** Dieter Baas
**Versie:** 1.0 — mei 2026
