# CONTRIBUTING — VORALYS

Ce document décrit comment travailler sur ce repo au quotidien : branches, issues, PR, revue,
et le cycle de vie complet d'un agent (cadrage → production).

## 1. Règle d'or

**Aucun push direct vers `main` ou `develop`.** Tout passe par une Pull Request revue.

## 2. Modèle de branches

```
main        ← production, protégée
 ↑
staging     ← pré-production / recette, protégée
 ↑
develop     ← intégration continue, protégée
 ↑
feature/*   ← travail en cours
```

Convention de nommage `feature/` (à créer depuis `develop`) :

```
feature/AG01-behavior
feature/AG01-workflow
feature/AG01-rag
feature/AG01-compliance
feature/AG01-tests
feature/backend-auth-orgid
feature/n8n-regwatch-ingest
```

### Réglages à activer sur GitHub (Settings → Branches)

- Protection sur `main`, `staging`, `develop` : PR obligatoire, ≥1 review (2 pour `main`), CI verte obligatoire, pas de force-push.
- `CODEOWNERS` actif pour forcer la review du bon spécialiste (voir `.github/CODEOWNERS`).

## 3. Issues — granularité par agent

Chaque tâche est une issue traçable, avec le label `agent:AGxx` et `role:*`. Exemple pour un agent :

| ID | Titre | Label |
|---|---|---|
| VOR-AG01-01 | Créer AG01 Master Spec | `role:dosso` |
| VOR-AG01-02 | Définir AG01 Behavior | `role:kevin` |
| VOR-AG01-03 | Définir AG01 RAG/KG | `role:ahiko` |
| VOR-AG01-04 | Construire AG01 Flow Langflow | `role:david` |
| VOR-AG01-05 | Revue Compliance AG01 | `role:patrick` |
| VOR-AG01-06 | Créer les tests AG01 | `role:qa` |
| VOR-AG01-07 | Audit Dev/Data/Cyber/QA AG01 | `role:audit` |

Utilisez le template `.github/ISSUE_TEMPLATE/agent_task.md`. Un script de création en masse
est fourni : `scripts/create_agent_issues.sh` (nécessite `gh` CLI authentifié).

Un tableau de bord GitHub Projects (vue Kanban) permet à tous — Dev, Data, Cyber, QA — de voir
l'avancement de chaque agent sans se marcher dessus : colonnes `Cadrage → Conception → Master Spec
→ Revue interne → Flow → Tests → PR → Audit → Correction → Approuvé → Prod`.

## 4. Cycle de vie d'un agent (AGxx)

```
1. Cadrage collectif (Dosso + Kevin + David + Ahiko + Patrick)
2. Conception spécialisée en parallèle (Behavior / Workflow / RAG-KG / Compliance)
3. Consolidation → AGxx_MASTER_SPEC_v0.1
4. Revue interne (les 5) → READY FOR AUDIT
5. Audit externe : Dev (faisabilité/API/runtime) · Data (RAG/KG/retrieval)
   · Cyber (auth/permissions/injection/secrets/tenant isolation) · QA (tests/critères/régression)
6. Findings → AGxx_AUDIT_FINDINGS.md (labels Critical/High/Medium)
7. Correction → retour au spécialiste concerné → AGxx_MASTER_SPEC_v0.2
8. Approbation → APPROVED FOR IMPLEMENTATION (findings critiques clos, contrat stable,
   tests définis, reviewers OK, sécurité acceptable)
9. Merge develop → staging → audit → production
```

### Definition of Done d'un agent

- [ ] Mission / Scope / Out-of-scope définis
- [ ] Contrat entrée/sortie défini et stable
- [ ] Behavior (rôle, prompts, règles, gestion incertitude, refus, tool policy)
- [ ] Workflow Langflow (séquences, branches, dépendances, gestion d'erreur)
- [ ] RAG + KG définis si nécessaire
- [ ] Sécurité (permissions, tenant isolation, secrets) validée par Cyber
- [ ] Error handling
- [ ] Tests (unitaires, intégration, régression) définis et passants
- [ ] Master Spec consolidée
- [ ] Audit Dev/Data/Cyber/QA réalisé, findings corrigés
- [ ] Version enregistrée dans `docs/agents/AGxx/`
- [ ] Validation obtenue

## 5. Pull Requests

- Utilisez `.github/pull_request_template.md`.
- Une PR = une issue (ou un petit groupe cohérent). Lien obligatoire `Closes #123`.
- La CI doit être verte : lint, tests, contrôle de contrat, contrôle d'isolation tenant.
- Revue par le CODEOWNER du domaine concerné (Behavior→Kevin, Workflow→David, Data/RAG→Ahiko,
  Compliance→Patrick, transverse→Dosso ; + Dev/Cyber/QA selon les fichiers touchés).

## 6. Secrets

Jamais de secret dans le repo. `.env.example` documente la structure, `.env` reste local et
est dans `.gitignore`. Clés LLM, JWT, mots de passe, clés de chiffrement : gestion via secret
manager / variables d'environnement CI, jamais en clair.

## 7. Décisions d'architecture (ADR)

Tout changement majeur (stack, contrat, RAG, architecture, workflow critique, sécurité, modèle
LLM) doit être documenté dans `docs/decisions/ADR-XXX.md` avant merge. Utilisez `docs/decisions/ADR_TEMPLATE.md`.
