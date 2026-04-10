#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: install_and_kickoff.sh <client-slug> [target-root]"
  echo "Example: install_and_kickoff.sh brother /home/workspace/Wiki"
  exit 1
fi

CLIENT="$1"
TARGET_ROOT="${2:-/home/workspace/Wiki}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
VAULT="${TARGET_ROOT}/${CLIENT}-wiki"

"${SCRIPT_DIR}/bootstrap_second_brain.sh" "$CLIENT" "$TARGET_ROOT"

cat > "${VAULT}/outputs/START-HERE-NEXT-MESSAGE.md" <<MSG
Level 1/4: Drop one note or file into your raw folder now:
${VAULT}/raw
Reply 'done' when it's there.
MSG

cat <<OUT

INSTALL_STATUS: SUCCESS
VAULT_PATH: ${VAULT}

NEXT_MESSAGE_TO_CLIENT:
Level 1/4: Drop one note or file into your raw folder now:
${VAULT}/raw
Reply 'done' when it's there.

FOLLOW_UP_FOR_AI_AGENT:
After the client replies 'done', run the onboarding game prompt from:
${REPO_ROOT}/operator-pack/ONBOARDING-GAME-SCRIPT.md
Replace <client-slug> with ${CLIENT}.
OUT
