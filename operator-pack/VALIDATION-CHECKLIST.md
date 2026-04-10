# Validation Checklist

A client setup is valid only if all checks pass.

## End-user simplicity

- [ ] Vault has visible core: `raw/`, `wiki/`, `outputs/`, `WIKI_SCHEMA.md`
- [ ] End-user instructions only reference `raw/` inputs
- [ ] No coding required for end user

## Hidden operator layer

- [ ] Hidden `.ops/` exists
- [ ] `.ops/bin/compile` runs successfully
- [ ] `.ops/bin/health-check` runs successfully
- [ ] `.ops/bin/backup` runs successfully
- [ ] `.ops/bin/weekly-digest` runs successfully

## Compile quality

- [ ] `wiki/index.md` exists
- [ ] At least 2 topic pages created in `wiki/`
- [ ] Topic pages reference source file names from `raw/`

## Question-answer loop

- [ ] A question was answered using `wiki/`
- [ ] Answer was saved to `outputs/`

## Weekly nudge loop

- [ ] Weekly digest exists in `outputs/`
- [ ] Digest includes one specific next action

## Operator simplicity

- [ ] New operator can follow setup in < 10 minutes
- [ ] Setup is copy/paste repeatable for another client
