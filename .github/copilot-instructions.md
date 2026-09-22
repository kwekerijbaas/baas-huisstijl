# GitHub Copilot — Kwekerij Baas

Follow the central guidelines in `docs/ai-coding-guidelines.md`.

## Additional for Copilot

- Code identifiers in English; user-facing text, commit messages, and Dutch business comments in Dutch.
- When suggesting Azure resources, always include the mandatory tags from the central guidelines.
- When suggesting secrets-related code, route through Azure Key Vault + Managed Identity — never hardcode.
- When suggesting SQL against data sources, target `gold` views only.
- When suggesting integrations with Business Central, NAV, or SNOOP, flag this for user confirmation before generating code.

## App-specific additions

<!-- Add app-specific instructions here that don't fit in the central guidelines. -->
