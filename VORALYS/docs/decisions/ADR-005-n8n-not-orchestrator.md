# ADR-005 — Pourquoi n8n ne fait-il pas l'orchestration métier ?

**Statut :** Accepté

## Contexte
Risque de dérive : utiliser n8n à la fois pour l'automatisation ET pour enchaîner les 20 agents,
ce qui créerait deux systèmes de routage concurrents et non auditable de façon unifiée.

## Décision
Le routage intent → agents reste exclusivement piloté par la table de routage versionnée
(TDR §3.2) exécutée via Langflow. n8n déclenche des automatisations (ex: nouvelle source
réglementaire → téléchargement → pipeline data → RAG → Langflow/Agent) mais ne décide jamais
quel agent métier appeler pour répondre à une requête utilisateur.

## Validation requise
- [ ] Revue Dosso
- [ ] Revue Dev
