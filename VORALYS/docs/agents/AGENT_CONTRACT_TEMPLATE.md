# AGxx_CONTRACT — [Nom de l'agent]

## IN
```json
{
  "org_id": "uuid",
  "...": "champs spécifiques à l'agent"
}
```

## OUT
```json
{
  "...": "sortie normalisée spécifique à l'agent",
  "source": {
    "url_or_ref": "string",
    "tier": "1|2|3|4",
    "publisher": "string",
    "retrieved_at": "datetime",
    "source_confidence": "0..1"
  },
  "confidence_level": "0..1"
}
```

## Règles de contrat
- Toute conclusion critique exige `tier <= 2`, sinon dégradation en
  `"Regulatory interpretation — confirmation recommended"`.
- Aucun champ inventé : en l'absence de donnée confirmée → `null` + flag `NOT_VERIFIED`, jamais
  une valeur plausible.
- Versionner ce contrat. Tout changement de contrat = ADR + revue Dev (breaking change ?).

## Compatibilité descendante
- [ ] Ce contrat est-il un breaking change pour les agents consommateurs en aval ?
- [ ] Si oui, plan de migration documenté dans l'ADR correspondant.
