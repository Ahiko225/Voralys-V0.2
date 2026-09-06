# AGxx_MASTER_SPEC_v0.1 — [Nom de l'agent]

> Copier ce fichier dans `docs/agents/AGxx/AGxx_MASTER_SPEC_v0.1.md`. Ne pas modifier la structure
> sans ADR. Consolidation des 4 contributions spécialisées + coordination Dosso.

## 1. Identity
- ID : AGxx
- Nom :
- Phase de développement :
- Criticité (LOW/MEDIUM/HIGH/CRITICAL) :

## 2. Mission

## 3. Scope

## 4. Out of Scope

## 5. Inputs
Format normalisé (JSON), champs obligatoires/optionnels.

## 6. Outputs
Contrat de sortie normalisé — voir `AGENT_CONTRACT_TEMPLATE.md`.

## 7. Business Rules
(Owner : Patrick — règles métier, distinction obligation/recommandation, exceptions)

## 8. Behavior
(Owner : Kevin — rôle, prompts, règles comportementales, gestion de l'incertitude, refus, tool policy)
Sous-livrables : `AGxx_BEHAVIOR.md`, `AGxx_PROMPT.md`, `AGxx_TOOL_POLICY.md`

## 9. RAG
(Owner : Ahiko) Bases RAG utilisées parmi {Legal, Regulatory, Standards, Insurance, Client, Threat},
métadonnées attendues, stratégie de retrieval.
Sous-livrable : `AGxx_RAG_REQUIREMENTS.md`

## 10. KG
(Owner : Ahiko) Nœuds/relations du Knowledge Graph nécessaires à l'agent.
Sous-livrable : `AGxx_KG_REQUIREMENTS.md`

## 11. Workflow
(Owner : David) Séquences, branches, conditions, dépendances, appels d'outils, gestion d'erreurs.
Sous-livrables : `AGxx_WORKFLOW.md`, `AGxx_FLOW` (export Langflow), `AGxx_DEPENDENCIES.md`

## 12. Tools
Liste des outils/API externes appelés par l'agent.

## 13. Errors
Comportement en cas d'échec : dégradation contrôlée + flag (ne bloque pas le DAG entier).

## 14. Security
(Revue Cyber) Permissions, tenant isolation, gestion des secrets, résistance à l'injection de prompt.

## 15. Dependencies
Agents amont/aval dans le DAG. Bases RAG/KG prérequises.

## 16. Evaluation
Critères de test, jeux de données d'évaluation, métriques (taux de sources Tier ≤2, etc.)

## 17. Acceptance Criteria
Ex. : aucune conclusion critique publiée sans source ≤ Tier 2 + niveau de confiance associé.

## 18. Validation
- [ ] Revue interne (Dosso, Kevin, David, Ahiko, Patrick) → READY FOR AUDIT
- [ ] Audit Dev
- [ ] Audit Data
- [ ] Audit Cyber
- [ ] Audit QA
- [ ] Findings corrigés → v0.2
- [ ] APPROVED FOR IMPLEMENTATION
