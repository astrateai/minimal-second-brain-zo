# Copy-Paste Setup (for any new client)

Use this exact sequence.

## 1) Bootstrap a new vault

```bash
./operator-pack/scripts/bootstrap_second_brain.sh <client-slug> /home/workspace/Wiki
```

This creates:

- `raw/`
- `wiki/`
- `outputs/`
- `WIKI_SCHEMA.md`
- hidden `.ops/` automation tools

## 2) End-user instruction (what client sees)

Tell the client only this:

```text
Drop your notes/files into /home/workspace/Wiki/<client-slug>-wiki/raw.
```

## 3) Run onboarding game (recommended first session)

Use: `operator-pack/ONBOARDING-GAME-SCRIPT.md`

It validates:
- raw intake
- wiki compile
- question-to-output loop
- weekly digest generation

## 4) Hidden operator commands (behind the scenes)

```bash
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/backup
./.ops/bin/weekly-digest
```

## 5) Weekly nudge setup

Use: `operator-pack/WEEKLY-DIGEST-AUTOMATION.md`

## 6) Optional 2-minute validation

```bash
./operator-pack/scripts/load_sample_fixture.sh /home/workspace/Wiki/<client-slug>-wiki
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/weekly-digest
```

## 7) Ongoing operating prompt (reusable)

```text
Use /home/workspace/Wiki/<client-slug>-wiki.
Follow WIKI_SCHEMA.md.
Process any new files in raw/, update wiki/, and keep wiki/index.md current.
Then ask me one high-leverage question to improve the knowledge base.
```
