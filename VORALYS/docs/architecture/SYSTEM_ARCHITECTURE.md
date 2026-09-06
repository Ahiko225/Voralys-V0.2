# SYSTEM_ARCHITECTURE — VORALYS

Référence normative : `TDR_Voralys_technique.pdf` (v1.0). Ce document sert d'index de navigation
technique pour l'équipe de développement.

## Flux nominal (7 couches)

```
Utilisateur / API
 │
 ▼
[C1] Orchestrator ──► Intent & Context Engine (extraction du contexte, PAS un agent du catalogue)
 │
 ▼
[C2] Agents spécialisés (AG01–AG20, exécution parallèle / DAG selon table de routage versionnée)
 │
 ▼
[C3] Evidence & Source Validation (AG08, AG17)
 │
 ▼
[C4] Cross-Agent Verification (AG16 Legal Consistency, AG18 Contradiction Resolver)
 │
 ▼
[C5] Risk & Confidence (AG11 Cyber Risk + Confidence Scorer transverse)
 │
 ▼
[C6] Response Composer (transverse, pas un agent métier)
 │
 ▼
[C7] Dashboard / Rapport / API
```

## Architecture technique (implémentation)

```
React (Dashboard) ──┐
                     ├──► FastAPI ──► Auth/RBAC + org_id ──► Intent & Context ──► Routing Policy
n8n (Automation) ────┘                                                              │
                                                                                     ▼
                                                                                 LANGFLOW
                                                                          (Agent & Workflow Runtime)
                                                                          ┌─────────┼─────────┐
                                                                          ▼         ▼         ▼
                                                                       Agents      RAG       Tools
                                                                                    │
                                                                                    ▼
                                                                          PostgreSQL + pgvector
                                                                                    │
                                                                                    ▼
                                                                          Knowledge Graph
```

**Règle d'architecture :** n8n ne devient jamais un second orchestrateur métier. Le routage des
20 agents reste gouverné par la policy de routage VORALYS + Langflow.

## Table de routage (extrait — voir TDR §3.2 pour la version complète)

| Intention | Agents obligatoires | Agents conditionnels |
|---|---|---|
| REGULATORY_APPLICABILITY | AG05, AG01, AG17, AG16 | AG06 (si `is_critical`), AG15 |
| COMPLIANCE_ASSESSMENT | AG07, AG03, AG08, AG17 | AG04, AG06 |
| GAP_ANALYSIS | AG07, AG09, AG03 | AG10, AG04 |
| RISK_EVAL | AG11, AG07 | AG06 |
| INSURANCE_EVAL | AG12, AG14, AG11 | AG13, AG07 |
| REGULATORY_WATCH | AG02, AG01, AG17 | AG16 |
| REPORT | AG20, AG19 | (dépend du rapport) |

Toute modification de cette table = ADR obligatoire (`docs/decisions/`).

## Bases RAG (6, cloisonnement documenté dans `data/rag/`)

| Base | Contenu | Cloisonnement | Priorité source |
|---|---|---|---|
| Legal RAG | Lois, décrets, arrêtés | Global | Tier 1 |
| Regulatory RAG | Référentiels nationaux | Global | Tier 1-2 |
| Standards RAG | ISO, NIST, CIS, IEC, PCI DSS | Global | Tier 3 |
| Insurance RAG | Conditions, garanties, exclusions | Global | Tier 4 vérifié |
| Client RAG | Documents client | **Par `org_id`** | N/A (interne) |
| Threat RAG | Menaces, vulnérabilités, incidents | Global | Tier 3-4 |

## Multi-tenant — flux `org_id`

```
User → Authentication → JWT → org_id → Security Context → FastAPI → Langflow → Agent → RAG/DB → RLS
```

Contrôle appliqué **au niveau backend/data** (RLS PostgreSQL), jamais uniquement via les
instructions du modèle. Un agent ne doit jamais pouvoir changer de `org_id` librement.

## Roadmap de développement

| Phase | Contenu | Livrable |
|---|---|---|
| Phase 1 — Core | Orchestrator, AG01, AG03, AG05, AG17, AG07, AG09 | Chaîne applicabilité → évaluation → écarts, sourcée |
| Phase 2 — Compliance Intelligence | AG04, AG08, AG10, AG06, AG11 | Roadmap de remédiation + score de risque |
| Phase 3 — Insurance Intelligence | AG12, AG13, AG14 | Analyse d'assurabilité + comparatif |
| Phase 4 — Advanced | AG02, AG15, AG16, AG18, AG19, AG20 | Radar réglementaire + reporting exécutif |

Le socle anti-hallucination et le cloisonnement tenant sont transverses et opérationnels **dès la Phase 1**.

## Points à confirmer avant technology freeze

Voir `docs/decisions/` — hébergement LLM, GPU/dimensionnement, stratégie d'auth définitive,
niveau d'intégration Supabase vs PostgreSQL direct, sauvegarde, monitoring, SLA. Ces points ne
doivent pas être inventés côté dev : ils remontent à Dosso / Product Owner.
