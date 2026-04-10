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
CLIENT_MESSAGE_FILE="${VAULT}/outputs/START-HERE-NEXT-MESSAGE.md"
ONBOARDING_FILE="${VAULT}/outputs/START-HERE-ONBOARDING-GAME-PROMPT.md"
RULE_FILE="${VAULT}/outputs/START-HERE-WIKI-RULE-PROMPT.md"
ONE_SHOT_FILE="${VAULT}/outputs/START-HERE-ONE-SHOT-INSTALL-ONBOARD-PROMPT.md"
FAQ_FILE="${REPO_ROOT}/operator-pack/CLIENT-FAQ.md"
POLICY_FILE="${REPO_ROOT}/operator-pack/WIKI-CAPTURE-POLICY.md"

"${SCRIPT_DIR}/bootstrap_second_brain.sh" "$CLIENT" "$TARGET_ROOT"

cat > "${CLIENT_MESSAGE_FILE}" <<MSG
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

sed "s|<client-slug>|${CLIENT}|g" "${REPO_ROOT}/operator-pack/ONBOARDING-GAME-SCRIPT.md" > "${ONBOARDING_FILE}"
sed "s|<client-slug>|${CLIENT}|g" "${REPO_ROOT}/operator-pack/ONE-SHOT-INSTALL-ONBOARD-PROMPT.md" > "${ONE_SHOT_FILE}"

cat > "${RULE_FILE}" <<RULE
Install this as my persistent wiki capture behavior for this workspace:

1) If a message starts with 'wiki:', capture that message (and any attachments) into raw.
2) If a message includes 'wiki this', capture the current item/thread into raw.
3) If a message includes 'no wiki', do not capture that message.
4) If I share a file or link, capture it into raw by default.
5) Regular chat with no file/link and no wiki command should not be auto-captured.

When applying this behavior:
- no wiki overrides everything
- explicit commands ('wiki:' / 'wiki this') override normal chat behavior
- file/link uploads auto-capture unless no wiki is present

My vault is: ${VAULT}
My raw folder is: ${VAULT}/raw
RULE

cat <<OUT

INSTALL_STATUS: SUCCESS
VAULT_PATH: ${VAULT}
CLIENT_MESSAGE_FILE: ${CLIENT_MESSAGE_FILE}
ONBOARDING_PROMPT_FILE: ${ONBOARDING_FILE}
WIKI_RULE_PROMPT_FILE: ${RULE_FILE}
ONE_SHOT_PROMPT_FILE: ${ONE_SHOT_FILE}
CLIENT_FAQ_FILE: ${FAQ_FILE}
CAPTURE_POLICY_FILE: ${POLICY_FILE}

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
1) Apply persistent behavior from:
${RULE_FILE}
2) After the client replies 'done', run onboarding prompt from:
${ONBOARDING_FILE}
3) If client is confused, use:
${FAQ_FILE}
Before onboarding levels, enforce trigger policy:
- Capture when message starts with 'wiki:' or includes 'wiki this'
- Skip when message includes 'no wiki'
- Auto-capture files/links
- Do not auto-capture regular chat without these triggers
OUT
