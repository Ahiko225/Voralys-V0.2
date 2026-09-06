# ADR-001 — Pourquoi Langflow comme runtime agentique ?

**Statut :** Proposé — à valider avant technology freeze

## Contexte
VORALYS nécessite un environnement de création/composition/exécution pour 20 agents avec
outils, RAG et logique agentique, en approche "low-code first" pour accélérer le développement.

## Décision
Langflow retenu comme runtime des agents et des flows. Intégrable par API et mécanismes MCP.

## Ce que Langflow ne couvre PAS (limites actées)
- Le système de sécurité
- La base de données
- Le moteur de conformité
- Le vérificateur juridique
- La propriété du org_id

## Validation requise
- [ ] Revue Dosso
- [ ] Revue Dev (intégration FastAPI/CI)
- [ ] Revue Cyber (sécurité des flows en production — point ouvert, voir ADR-006 hébergement LLM)
