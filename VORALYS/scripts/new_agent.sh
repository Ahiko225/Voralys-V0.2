#!/usr/bin/env bash
# Crée le dossier docs/agents/AGxx/ pré-rempli à partir des templates communs.
#
# Usage :
#   bash scripts/new_agent.sh AG02 "Regulatory Watch"

set -euo pipefail

AGENT_ID="${1:?Usage: new_agent.sh AGxx \"Nom de l'agent\"}"
AGENT_NAME="${2:?Usage: new_agent.sh AGxx \"Nom de l'agent\"}"

DIR="docs/agents/${AGENT_ID}"

if [ -d "$DIR" ]; then
  echo "Le dossier $DIR existe déjà — abandon."
  exit 1
fi

mkdir -p "$DIR"

sed "s/AGxx/${AGENT_ID}/g; s/\[Nom de l'agent\]/${AGENT_NAME}/g" \
  docs/agents/AGENT_MASTER_TEMPLATE.md > "$DIR/${AGENT_ID}_MASTER_SPEC_v0.1.md"

sed "s/AGxx/${AGENT_ID}/g; s/\[Nom de l'agent\]/${AGENT_NAME}/g" \
  docs/agents/AGENT_CONTRACT_TEMPLATE.md > "$DIR/${AGENT_ID}_CONTRACT.md"

sed "s/AGxx/${AGENT_ID}/g; s/\[Nom de l'agent\]/${AGENT_NAME}/g" \
  docs/agents/AGENT_TEST_TEMPLATE.md > "$DIR/${AGENT_ID}_TESTS.md"

cat > "$DIR/${AGENT_ID}_AUDIT_FINDINGS.md" << EOF
# ${AGENT_ID}_AUDIT_FINDINGS — ${AGENT_NAME}

| ID | Domaine | Sévérité | Constat | Owner correction | Statut |
|---|---|---|---|---|---|
EOF

echo "Agent ${AGENT_ID} (${AGENT_NAME}) créé dans ${DIR}/"
echo "N'oubliez pas de :"
echo "  1. Mettre à jour le statut dans docs/agents/AGENT_REGISTRY.md"
echo "  2. Lancer scripts/create_agent_issues.sh ${AGENT_ID} \"${AGENT_NAME}\""
echo "  3. Créer la branche feature/${AGENT_ID}-behavior (etc.) depuis develop"
