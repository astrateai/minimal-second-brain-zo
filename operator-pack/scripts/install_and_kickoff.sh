#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: install_and_kickoff.sh <client-slug> [target-root]"
  echo "Example: install_and_kickoff.sh wife /home/workspace/Wiki"
  exit 1
fi

CLIENT="$1"
TARGET_ROOT="${2:-/home/workspace/Wiki}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
VAULT="${TARGET_ROOT}/${CLIENT}-wiki"
ONBOARDING_FILE="${VAULT}/outputs/START-ONBOARDING.md"

"${SCRIPT_DIR}/bootstrap_second_brain.sh" "$CLIENT" "$TARGET_ROOT"
mkdir -p "${VAULT}/outputs"
find "${VAULT}/outputs" -maxdepth 1 -type f \( -name "START-HERE-*" -o -name "START-ONBOARDING.md" \) -delete

sed "s|<client-slug>|${CLIENT}|g" "${REPO_ROOT}/operator-pack/ONBOARDING-GAME-SCRIPT.md" > "${ONBOARDING_FILE}"

cat <<OUT

INSTALL_STATUS: SUCCESS
VAULT_PATH: ${VAULT}
ONBOARDING_FILE: ${ONBOARDING_FILE}

NEXT_STEP:
Paste the entire contents of ${ONBOARDING_FILE} into the client's Zo chat.
OUT
