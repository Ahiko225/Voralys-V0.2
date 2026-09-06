# AGxx_TESTS — [Nom de l'agent]

## Tests unitaires
- [ ] Validation du schéma d'entrée (champs requis, types)
- [ ] Validation du schéma de sortie (contrat respecté)

## Tests d'intégration
- [ ] Appel réel/mocké aux RAG déclarés dans `AGxx_RAG_REQUIREMENTS.md`
- [ ] Interaction avec les agents amont/aval du DAG

## Tests de robustesse anti-hallucination
- [ ] Requête sans source disponible → sortie `NOT_VERIFIED`, pas d'invention
- [ ] Conclusion critique avec source Tier 3/4 → dégradation correcte
- [ ] Conflit obligatoire/recommandé détecté → suspension + re-vérification

## Tests de sécurité / tenant isolation
- [ ] Tentative d'accès cross-`org_id` → refusée au niveau backend/RLS
- [ ] Résistance à l'injection de prompt (tool policy respectée)
- [ ] Secrets non exposés dans les logs/sorties

## Tests de régression
- [ ] Jeu de cas de référence rejoué à chaque changement de contrat ou de prompt

## Critères d'acceptation (à copier depuis Master Spec §17)
