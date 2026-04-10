# Hidden Ops Layer

This folder is for operators, not end users.

## Commands

Run from vault root:

```bash
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/backup
./.ops/bin/weekly-digest
```

## Purpose

- `compile`: turns `raw/` files into structured topic pages in `wiki/` and updates `wiki/index.md`
- `health-check`: writes a quality report to `outputs/`
- `backup`: creates timestamped archive snapshots in `.ops/backups/`
- `weekly-digest`: writes a 7-day summary + one next action nudge to `outputs/`

End users should still only be instructed to add sources to `raw/`.
