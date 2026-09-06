# ADR-004 — Pourquoi org_id comme clé de partition ?

**Statut :** Proposé — à valider avant technology freeze

## Contexte
Principe directeur non négociable du TDR : séparation stricte des données par organisation,
aucune mémoire ni RAG client partagé entre tenants.

## Décision
`org_id` est propagé JWT → Security Context → FastAPI → Langflow → Agent → RAG/DB, et appliqué
en Row-Level Security PostgreSQL. Le contrôle est fait au niveau backend/data, jamais uniquement
dans les instructions du modèle.

## Conséquences
- Toute table métier doit porter `org_id` et une policy RLS associée.
- Un agent ne peut jamais changer ORG_A → ORG_B de sa propre initiative.

## Validation requise
- [ ] Revue Cyber (obligatoire, critique)
- [ ] Revue Data
- [ ] Revue Dev
