# TEST_STRATEGY — VORALYS

## Niveaux de test

| Niveau | Responsable | Porte de sortie |
|---|---|---|
| Unitaire (schéma in/out par agent) | QA + Owner agent | CI verte sur la PR |
| Intégration (DAG multi-agents) | QA + David | Avant merge `develop` → `staging` |
| Sécurité (tenant isolation, injection, secrets) | Cyber | Avant `APPROVED FOR IMPLEMENTATION` |
| Régression (jeu de cas de référence) | QA | À chaque changement de contrat/prompt |
| Recette fonctionnelle (chaîne bout en bout) | Product Owner + Patrick | Avant `staging` → `main` |

## Cas obligatoires transverses (tous agents)

1. Absence de source disponible → sortie `NOT_VERIFIED`, jamais d'invention.
2. Conclusion critique avec source Tier 3/4 uniquement → dégradation en interprétation.
3. Conflit obligatoire/recommandé détecté entre deux agents → suspension + re-vérification.
4. Confusion de statut normatif (guide présenté comme loi) → correction forcée avant composition.
5. Tentative d'accès cross-`org_id` → échec au niveau backend.
6. Échec d'un agent dans le DAG → dégradation contrôlée, le DAG entier ne bloque pas.

## KPIs à instrumenter (cibles TDR §10)

| KPI | Cible |
|---|---|
| Conclusions réglementaires critiques sourcées | 100 % |
| Réponses réglementaires vérifiées (Tier ≤ 2) | ≥ 95 % |
| Taux d'erreurs réglementaires | → 0 |
| Contradictions détectées avant publication | 100 % |
| Temps moyen d'analyse | à instrumenter (SLA à définir, cf. ADR-006) |

## Critère d'acceptation bloquant global
Aucune conclusion réglementaire critique publiée sans source vérifiable ≤ Tier 2 et niveau de
confiance associé.
