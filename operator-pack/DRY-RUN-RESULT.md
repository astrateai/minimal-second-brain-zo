# Dry Run Result (alex-v2-wiki with hidden ops)

Vault tested: `/home/workspace/Wiki/alex-v2-wiki`
Date: 2026-04-10 UTC

## Checklist Status

- [x] Vault has visible core: `raw/`, `wiki/`, `outputs/`, `WIKI_SCHEMA.md`
- [x] End-user instruction remains: "only add files to raw"
- [x] Hidden `.ops/` exists
- [x] `.ops/bin/compile` runs successfully
- [x] `.ops/bin/health-check` runs successfully
- [x] `.ops/bin/backup` runs successfully
- [x] `.ops/bin/weekly-digest` runs successfully
- [x] `wiki/index.md` generated
- [x] At least one topic page generated from raw source
- [x] Health report written to `outputs/`
- [x] Weekly digest written to `outputs/`
- [x] Backup archive written to `.ops/backups/`

## Validation Artifacts

- Raw source:
  - `raw/2026-04-10-v2-kickoff.md`
- Wiki outputs:
  - `wiki/v2-kickoff.md`
  - `wiki/index.md`
- Operator outputs:
  - `outputs/2026-04-10-compile-run.md`
  - `outputs/2026-04-10-health-check.md`
  - `outputs/2026-04-10-weekly-digest.md`
  - `.ops/backups/vault-backup-20260410-022503.tar.gz`
