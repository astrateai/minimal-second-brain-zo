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
Welcome to your 2nd Brain.
Purpose: you dump information once, and Zo organizes it so you can ask better questions later.

Your only job: send source material into raw.

Raw folder:
${VAULT}/raw

Fast ways to do that:
1) Upload a file to that folder.
2) Paste text directly in chat and say: "Save this to my raw folder."
3) Text Zo and say: "Save this note to my raw folder."

What gets saved to your wiki automatically:
- Any file or link you share in chat
- Any message that starts with: wiki:
- Any message that includes: wiki this

What does not get saved:
- Any message that includes: no wiki
- Regular chat with no file/link and no wiki command

When you've added your first item, reply: done
MSG

cat <<OUT

INSTALL_STATUS: SUCCESS
VAULT_PATH: ${VAULT}

NEXT_MESSAGE_TO_CLIENT:
Welcome to your 2nd Brain.
Purpose: you dump information once, and Zo organizes it so you can ask better questions later.

Your only job: send source material into raw.

Raw folder:
${VAULT}/raw

Fast ways to do that:
1) Upload a file to that folder.
2) Paste text directly in chat and say: "Save this to my raw folder."
3) Text Zo and say: "Save this note to my raw folder."

What gets saved to your wiki automatically:
- Any file or link you share in chat
- Any message that starts with: wiki:
- Any message that includes: wiki this

What does not get saved:
- Any message that includes: no wiki
- Regular chat with no file/link and no wiki command

When you've added your first item, reply: done

FOLLOW_UP_FOR_AI_AGENT:
After the client replies 'done', run the onboarding game prompt from:
${REPO_ROOT}/operator-pack/ONBOARDING-GAME-SCRIPT.md
Replace <client-slug> with ${CLIENT}.
Before onboarding levels, enforce trigger policy:
- Capture when message starts with 'wiki:' or includes 'wiki this'
- Skip when message includes 'no wiki'
- Auto-capture files/links
- Do not auto-capture regular chat without these triggers
OUT
