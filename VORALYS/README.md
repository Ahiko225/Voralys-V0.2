# VORALYS — Regulatory & Cyber-Insurance Decision Engine

**Organisation :** HIERO DIGITAL INTERNATIONAL
**Statut :** Cadrage validé — développement en cours
**Réf. documentaire :** `TDR_Voralys_technique.pdf` (v1.0) + `Fiche_Technique_Architecture_Organisation.pdf` (v0.2)

VORALYS est un système **multi-agents orchestré** combinant quatre intelligences — réglementaire,
conformité, risque cyber, assurance — reliées par un Knowledge Graph et un socle anti-hallucination
à sources vérifiables.

## Stack retenue

| Brique | Rôle |
|---|---|
| **React** | Dashboard / restitution |
| **FastAPI** | Point d'entrée applicatif, auth/RBAC, propagation `org_id` |
| **Langflow** | Runtime de création/composition/exécution des agents |
| **n8n** | Automatisation & intégrations externes (n'orchestre PAS les agents métier) |
| **PostgreSQL + pgvector** | Données + RAG vectoriel |
| **Knowledge Graph** | Raisonnement transversal (Country→Regulation→Requirement→Control→Evidence) |
| **Redis** | Cache / coordination |
| **Docker / Linux** | Déploiement |
| **GitHub** | Source de vérité : code, specs, versioning, CI/CD, audit |

## Principes non négociables

1. **Traçabilité** — toute conclusion réglementaire critique porte une source ≥ Tier 2 + un niveau de confiance.
2. **Isolation stricte par `org_id`** — aucun accès cross-tenant par défaut (RAG, mémoire, logs, DB via RLS).
3. **Hiérarchie des normes** — loi > décret > arrêté > référentiel > norme > guide > recommandation.
4. **Anti-hallucination par défaut** — information non confirmée = "Information not verified".
5. **Orchestration explicite et versionnée** — routage par table déterministe (pas de choix libre du LLM).

Voir [`docs/architecture/SYSTEM_ARCHITECTURE.md`](docs/architecture/SYSTEM_ARCHITECTURE.md) pour le détail complet.

## Démarrage rapide

```bash
git clone <repo_url>
cp .env.example .env        # remplir les secrets localement — jamais commités
docker compose up -d        # PostgreSQL + Redis + services
```

Prérequis : Git, Docker, Python 3.11+, Node.js, PostgreSQL, Redis.

## Organisation des dossiers

```
VORALYS/
├── docs/
│   ├── architecture/     # Architecture système, décisions de stack
│   ├── agents/           # Registre + spec de chaque agent (AG01–AG20)
│   ├── decisions/        # ADR (Architecture Decision Records)
│   ├── security/         # Modèle de menace, RLS, tenant isolation
│   └── testing/          # Stratégie de test globale
├── agents/               # Configs/exports Langflow par agent
├── data/
│   ├── rag/              # Pipelines d'ingestion par base RAG (Legal, Regulatory, Standards, Insurance, Client, Threat)
│   └── knowledge_graph/  # Schéma et scripts du KG
├── langflow/             # Flows exportés, composants custom
├── n8n/                  # Workflows d'automatisation exportés
├── backend/              # FastAPI
├── frontend/             # React
├── tests/                # Tests transverses
├── infra/                # Docker, IaC, CI support
└── .github/              # Templates Issues/PR, workflows CI
```

## Équipe IA Agentique — responsabilités

| Rôle | Personne | Sous-livrables |
|---|---|---|
| Lead Agent Engineering / Integrator | Dosso Mehoue Aimé | Master Specs, registre agents, coordination |
| Agent Behavior & Automation | Kevin | `AGxx_BEHAVIOR.md`, `AGxx_PROMPT.md`, `AGxx_TOOL_POLICY.md` |
| Agent Workflow / Langflow | David | `AGxx_WORKFLOW.md`, `AGxx_FLOW`, `AGxx_DEPENDENCIES.md` |
| Agent Data/RAG Liaison | Ahiko | `AGxx_RAG_REQUIREMENTS.md`, `AGxx_DATA_REQUIREMENTS.md`, `AGxx_KG_REQUIREMENTS.md` |
| Compliance & Domain Specialist | Patrick | `AGxx_DOMAIN_RULES.md`, `AGxx_COMPLIANCE_REVIEW.md` |

Chaque agent est audité par **Dev, Data, Cyber, QA** avant `APPROVED FOR IMPLEMENTATION`.
Voir [`CONTRIBUTING.md`](CONTRIBUTING.md) pour le processus complet.
