# AGENT_REGISTRY — VORALYS

Vue d'ensemble des 20 agents. Chaque ligne pointe vers `docs/agents/AGxx/` pour la spec détaillée.
Mettre à jour le **Statut** à chaque étape du cycle de vie (voir `CONTRIBUTING.md` §4).

Statuts possibles : `Cadrage` · `Conception` · `Master Spec v0.1` · `Revue interne` ·
`Ready for audit` · `En audit` · `Findings` · `Master Spec v0.2` · `Approved` · `En prod`

| ID | Agent | Phase | Fonction | Statut | Owner spec (Dosso/Kevin/David/Ahiko/Patrick) |
|---|---|---|---|---|---|
| AG01 | Regulatory Intelligence | 1 | Exigences réglementaires | Cadrage | — |
| AG02 | Regulatory Watch | 4 | Veille | Cadrage | — |
| AG03 | Standards Intelligence | 1 | Standards / contrôles | Cadrage | — |
| AG04 | Compliance Mapping | 2 | Mapping contrôle ↔ framework | Cadrage | — |
| AG05 | Applicability | 1 | Applicabilité réglementaire | Cadrage | — |
| AG06 | Critical Infrastructure | 2 | Criticité | Cadrage | — |
| AG07 | Compliance Assessment | 1 | Évaluation | Cadrage | — |
| AG08 | Evidence | 2 | Preuves | Cadrage | — |
| AG09 | Gap Analysis | 1 | Écarts | Cadrage | — |
| AG10 | Remediation Planner | 2 | Remédiation | Cadrage | — |
| AG11 | Cyber Risk | 2 | Risque cyber | Cadrage | — |
| AG12 | Cyber Insurance | 3 | Besoins d'assurance | Cadrage | — |
| AG13 | Insurance Comparator | 3 | Comparaison d'offres | Cadrage | — |
| AG14 | Insurance Readiness | 3 | Assurabilité | Cadrage | — |
| AG15 | Provider Qualification | 4 | Qualification prestataire | Cadrage | — |
| AG16 | Legal Consistency | 4 | Cohérence normative | Cadrage | — |
| AG17 | Source Verification | 1 | Vérification des sources | Cadrage | — |
| AG18 | Contradiction Resolver | 4 | Résolution de contradictions | Cadrage | — |
| AG19 | Executive Advisor | 4 | Synthèse exécutive | Cadrage | — |
| AG20 | Report Generator | 4 | Rapport | Cadrage | — |

## Fonctions transverses (ne PAS traiter comme des agents 21+)

| Composant | Rôle |
|---|---|
| Intent & Context Engine | Extraction du contexte (intent, country, sector, org_id, is_critical) |
| Routing Policy | Table de routage déterministe intent → agents |
| Confidence Scorer | Niveau de confiance global à partir des vérifications |
| Response Composer | Assemblage réponse + sources + classification + flags |

## Dépendances critiques à respecter dans l'ordre de développement

- AG17 (Source Verification) et AG16 (Legal Consistency) doivent précéder tout affichage de conclusion, dès Phase 1.
- Le Knowledge Graph conditionne AG04 (Compliance Mapping, Phase 2) — à amorcer en Phase 1.
- AG11 (Cyber Risk, Phase 2) est un prérequis de l'Insurance Intelligence (Phase 3).
