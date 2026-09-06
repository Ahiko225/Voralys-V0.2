# ADR-003 — Pourquoi PostgreSQL/pgvector ?

**Statut :** Proposé — à valider avant technology freeze

## Contexte
Besoin d'un stockage relationnel transactionnel (OrganizationProfile, audit trail) ET d'une
recherche vectorielle pour le RAG, avec isolation stricte par org_id (RLS).

## Décision
PostgreSQL + extension pgvector.

## Alternatives considérées
- Base vectorielle dédiée (Pinecone, Weaviate, etc.) + PostgreSQL séparé — écarté pour limiter
  la complexité opérationnelle en phase 1, à réévaluer si le volume RAG l'exige.

## Validation requise
- [ ] Revue Data
- [ ] Revue Dev (dimensionnement infra)
