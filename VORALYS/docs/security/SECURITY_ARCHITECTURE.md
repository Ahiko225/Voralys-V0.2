# SECURITY_ARCHITECTURE — VORALYS

## Périmètre de responsabilité Cyber
Threat model · Authentification · Permissions · Résistance à l'injection · Gestion des secrets ·
Tenant isolation · Sécurité des outils et workflows (Langflow/n8n).

## Isolation multi-tenant (critique — voir ADR-004)
- Partition par `org_id` à tous les niveaux : RAG, mémoire, logs, base de données (RLS PostgreSQL).
- Aucun accès cross-tenant par défaut.
- Contrôle appliqué au niveau backend/data — jamais uniquement via les instructions du modèle.
- Test obligatoire à chaque agent : tentative d'accès cross-`org_id` → doit échouer.

## Gestion des secrets
- Jamais de secret dans GitHub (`.env` dans `.gitignore`, `.env.example` documente la structure).
- Clés LLM, JWT, mots de passe, clés de chiffrement : hors repository, gérés via variables
  d'environnement / secret manager CI.

## Chiffrement
- Au repos et en transit (exigence non fonctionnelle du TDR).

## Sécurité des agents (Langflow)
- Tool policy explicite par agent (`AGxx_TOOL_POLICY.md`) : quels outils, quelles permissions.
- Résistance à l'injection de prompt testée dans `AGxx_TESTS.md`.
- Un agent en échec ne bloque pas le DAG entier : dégradation contrôlée + flag.

## Chaîne de vérification avant publication (critère d'acceptation bloquant)
```
Agent métier → Evidence (AG08) → Source Verification (AG17) → Legal Consistency (AG16)
→ Contradiction Resolver (AG18) → Confidence → PUBLISH / BLOCK / DEGRADE
```
Aucune conclusion réglementaire critique ne peut être publiée sans source vérifiable ≤ Tier 2
et niveau de confiance associé.

## CI/CD — contrôles de sécurité automatisés
Voir `.github/workflows/ci.yml` : lint, tests, contrats, tests de sécurité, contrôles d'isolation.

## Revue de sécurité obligatoire
Chaque agent passe par un audit Cyber avant `APPROVED FOR IMPLEMENTATION` (voir `CONTRIBUTING.md`).
