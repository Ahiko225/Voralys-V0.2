# AG01_CONTRACT — Regulatory Intelligence

## IN
```json
{
  "org_id": "uuid",
  "country": "ISO-3166 (ex: CI)",
  "sector": "BANKING|TELECOM|ENERGY|HEALTH|GOV|..."
}
```

## OUT
```json
{
  "requirements": [
    {
      "requirement": "string",
      "legal_basis": "loi|décret|arrêté|référentiel",
      "article": "string",
      "authority": "string",
      "effective_date": "date",
      "applicability": "string",
      "source": {
        "url_or_ref": "string",
        "tier": "1|2|3|4",
        "publisher": "string",
        "retrieved_at": "datetime",
        "source_confidence": "0..1"
      },
      "confidence_level": "0..1"
    }
  ]
}
```

Règle : conclusion critique → `tier <= 2` obligatoire, sinon dégradation
`"Regulatory interpretation — confirmation recommended"`.
