# Copy-Paste Setup (for any new client)

Use either path below.

## Path A: one-liner remote install (recommended)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) <client-slug> /home/workspace/Wiki
```

This installs everything and prints the exact first onboarding message.

Also creates these client-specific files inside the vault:

- `outputs/START-HERE-WIKI-RULE-PROMPT.md`
- `outputs/START-HERE-NEXT-MESSAGE.md`
- `outputs/START-HERE-ONBOARDING-GAME-PROMPT.md`

## Path B: local repo install

```bash
./operator-pack/scripts/install_and_kickoff.sh <client-slug> /home/workspace/Wiki
```

## End-user instruction (what client sees)

Tell the client only this:

```text
Drop your notes/files into /home/workspace/Wiki/<client-slug>-wiki/raw.
```

Then teach this exact trigger model:

```text
What gets saved to wiki:
- Files or links you share in chat
- Messages that start with "wiki:"
- Messages that include "wiki this"

What does NOT get saved:
- Messages that include "no wiki"
- Regular chat with no file/link and no wiki command
```

Canonical reference: `operator-pack/WIKI-CAPTURE-POLICY.md`


## 3.5) Explain value before instructions (recommended)

Use: `operator-pack/CLIENT-FAQ.md`

## Run onboarding game (recommended first session)

Use: `operator-pack/ONBOARDING-GAME-SCRIPT.md`

It validates:
- raw intake
- wiki compile
- question-to-output loop
- weekly digest generation

For exact no-guessing sequence, use: `operator-pack/PERFECT-PILOT-RUNBOOK.md`

## Hidden operator commands (behind the scenes)

```bash
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/backup
./.ops/bin/weekly-digest
```

## Weekly nudge setup

Use: `operator-pack/WEEKLY-DIGEST-AUTOMATION.md`

## Optional 2-minute validation

```bash
./operator-pack/scripts/load_sample_fixture.sh /home/workspace/Wiki/<client-slug>-wiki
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/weekly-digest
```

## Ongoing operating prompt (reusable)

```text
Use /home/workspace/Wiki/<client-slug>-wiki.
Follow WIKI_SCHEMA.md.
Process any new files in raw/, update wiki/, and keep wiki/index.md current.
Then ask me one high-leverage question to improve the knowledge base.
```
