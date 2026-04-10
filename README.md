# Minimal Second Brain (Zo)

A dead-simple second brain system for non-technical users.

## End-user workflow

Only one instruction:

- Put files in `raw/`

Optional chat shortcuts for capture:

- `wiki:` at message start -> force capture
- `wiki this` -> force capture current item
- `no wiki` -> force skip
- file/link shared -> auto-capture
- plain chat with no trigger -> no auto-capture

Everything else is handled by AI/operator automation.

## What this repo includes

- `template-minimal/`
  - `raw/`, `wiki/`, `outputs/`
  - `WIKI_SCHEMA.md`
  - hidden `.ops/` automation layer
- `operator-pack/`
  - copy/paste setup
  - onboarding game script
  - weekly digest setup
  - validation checklist
  - bootstrap + installer scripts

## Fastest install (agent-friendly)

From any terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) <client-slug> /home/workspace/Wiki
```

Example:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) wife /home/workspace/Wiki
```

This does all of the following:

- downloads/updates repo
- creates `<client-slug>-wiki` vault
- installs hidden `.ops` automation
- prints the exact next onboarding message to send the client

## Local repo install

From repo root:

```bash
./operator-pack/scripts/install_and_kickoff.sh <client-slug> /home/workspace/Wiki
```

## Operator commands (hidden from end user)

```bash
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/backup
./.ops/bin/weekly-digest
```

## Pilot flow (wife/brother)

1. Run installer.
2. Send the printed "NEXT_MESSAGE_TO_CLIENT".
3. Run onboarding game from `operator-pack/ONBOARDING-GAME-SCRIPT.md`.
4. Use `operator-pack/CLIENT-FAQ.md` for noob-first explanation.
5. Confirm success using `operator-pack/PILOT-SUCCESS-SCORECARD.md`.

## Notes

- Keep client experience simple.
- Keep reliability in hidden `.ops/` commands.
