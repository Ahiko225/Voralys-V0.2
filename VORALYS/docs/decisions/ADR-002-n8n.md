# ADR-002 — Pourquoi n8n comme couche d'automatisation ?

**Statut :** Proposé — à valider avant technology freeze

## Contexte
Besoin de cron, webhooks, collecte de documents, notifications, intégrations d'API, reporting
automatisé, sans dupliquer la logique métier des agents.

## Décision
n8n retenu pour l'automatisation et l'intégration externe uniquement.

## Règle non négociable
n8n NE DOIT PAS devenir un second orchestrateur métier des 20 agents. Le workflow agentique
reste maîtrisé par Langflow et la politique de routage VORALYS (voir ADR-005).

## Validation requise
- [ ] Revue Dosso
- [ ] Revue Dev
