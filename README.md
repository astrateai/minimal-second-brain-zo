# Minimal Second Brain (Zo)

A dead-simple second brain system for non-technical users.

## End-user workflow

Only one instruction:

- Put files in `raw/`

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
  - bootstrap script

## 60-second install

From repo root:

```bash
./operator-pack/scripts/bootstrap_second_brain.sh <client-slug> /home/workspace/Wiki
```

Example:

```bash
./operator-pack/scripts/bootstrap_second_brain.sh brother /home/workspace/Wiki
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

1. Bootstrap vault with script.
2. Give client one instruction: "drop files in raw/."
3. Run onboarding game from `operator-pack/ONBOARDING-GAME-SCRIPT.md`.
4. Confirm success using `operator-pack/PILOT-SUCCESS-SCORECARD.md`.
5. (Optional) run sample fixture via `operator-pack/scripts/load_sample_fixture.sh`.

## Notes

- Keep client experience simple.
- Keep reliability in hidden `.ops/` commands.
