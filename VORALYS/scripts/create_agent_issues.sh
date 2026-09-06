#!/usr/bin/env bash
# Crée en masse les issues du cycle de vie pour un agent donné.
# Nécessite : gh CLI authentifié (`gh auth login`) et exécuté depuis un clone du repo.
#
# Usage :
#   bash scripts/create_agent_issues.sh AG01 "Regulatory Intelligence"

set -euo pipefail

AGENT_ID="${1:?Usage: create_agent_issues.sh AGxx \"Nom de l'agent\"}"
AGENT_NAME="${2:?Usage: create_agent_issues.sh AGxx \"Nom de l'agent\"}"

declare -a TASKS=(
  "Cadrage collectif ${AGENT_ID}|role:dosso|Définir mission, scope, out-of-scope, inputs, outputs, criticité avec les 5 membres."
  "Définir ${AGENT_ID} Behavior|role:kevin|Rôle, prompts, règles comportementales, gestion incertitude, refus, tool policy."
  "Définir ${AGENT_ID} RAG/KG|role:ahiko|Bases RAG utilisées, métadonnées, besoins Knowledge Graph."
  "Construire ${AGENT_ID} Flow Langflow|role:david|Séquences, branches, dépendances, gestion d'erreurs."
  "Revue Compliance ${AGENT_ID}|role:patrick|Règles métier, classification normative, distinction obligation/recommandation."
  "Consolider ${AGENT_ID} Master Spec v0.1|role:dosso|Intégrer les 4 contributions dans AGxx_MASTER_SPEC_v0.1.md."
  "Créer les tests ${AGENT_ID}|role:qa|À partir de AGENT_TEST_TEMPLATE.md."
  "Audit Dev/Data/Cyber/QA ${AGENT_ID}|role:audit|Faisabilité, RAG/KG, sécurité/tenant isolation, critères d'acceptation."
)

for task in "${TASKS[@]}"; do
  IFS='|' read -r title label body <<< "$task"
  gh issue create \
    --title "[${AGENT_ID}] ${title}" \
    --label "agent-task" \
    --label "agent:${AGENT_ID}" \
    --label "${label}" \
    --body "**Agent :** ${AGENT_ID} — ${AGENT_NAME}

${body}

Voir \`docs/agents/${AGENT_ID}/\` et \`CONTRIBUTING.md\` §4 pour le cycle de vie complet."
done

echo "Issues créées pour ${AGENT_ID} — ${AGENT_NAME}"
