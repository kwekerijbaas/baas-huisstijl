# Architecture Decision Records (ADRs)

Iedere niet-triviale architectuurkeuze wordt vastgelegd als ADR. Een ADR beschrijft kort: wat is de keuze, waarom, welke alternatieven zijn overwogen, welke consequenties zijn er.

## Wanneer een ADR?

- Afwijken van de standaard-stack uit `docs/ai-coding-guidelines.md`.
- Keuze tussen meerdere reële opties (bijv. Container Apps versus App Service, Azure SQL versus PostgreSQL).
- Wijziging in datacontract (gold-view, API) met impact buiten deze repo.
- Beveiligings- of compliance-keuze die niet vanzelfsprekend is.

## Hoe maak je een ADR?

1. Kopieer `0000-template.md` naar `NNNN-korte-titel.md` (NNNN = volgnummer, met leading zeros).
2. Vul de secties in.
3. Status begint op `Voorgesteld`. Na akkoord → `Aanvaard`. Bij vervanging → `Vervangen door NNNN`.
4. Voeg toe in dezelfde PR als de wijziging waarop de ADR betrekking heeft.

## Index

- `0000-template.md` — sjabloon (geen ADR zelf)
