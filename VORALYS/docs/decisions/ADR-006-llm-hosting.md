# ADR-006 — Mode d'hébergement du LLM

**Statut :** OUVERT — à trancher avant technology freeze complet

## Contexte
Le choix de LLM (Mistral/OpenAI ou autre) et son mode d'hébergement impactent la souveraineté
des données, le coût, la latence et la conformité sectorielle (ex : secteur bancaire/GOV).

## Points à trancher
- Fournisseur/localisation de l'hébergement
- Besoin GPU/NVIDIA dédié
- Dimensionnement VPS/infrastructure
- Politique de souveraineté par pays/secteur (cf. exigence non fonctionnelle "Souveraineté" du TDR)

## Ne pas inventer
Ces éléments ne doivent pas être décidés unilatéralement par l'équipe dev — remontée requise
au Product Owner / porteur produit avant tout freeze technique.

## Validation requise
- [ ] Décision Product Owner
- [ ] Revue Cyber
- [ ] Revue Dev (infra)
