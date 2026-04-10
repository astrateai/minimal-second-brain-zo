# Minimal Second Brain Template

This template is intentionally simple for end users.

## End-user rule

Only add source files to `raw/`.

## AI/Operator responsibilities

- organize knowledge pages in `wiki/`
- answer questions into `outputs/`
- run periodic health checks and backups via hidden `.ops/`

## First run

1. Put at least 3 source files into `raw/`.
2. Run compile (`.ops/bin/compile`) or ask AI to compile.
3. Ask one real question and save answer into `outputs/`.
4. Run health check (`.ops/bin/health-check`).
