# Weekly Digest Automation (Operator)

Goal: produce a weekly nudge file in `outputs/`.

## Manual command

```bash
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/weekly-digest
```

## Zo automation suggestion

Create a weekly automation in [Automations](/?t=automations):

- Schedule: weekly (pick day/time in client timezone)
- Instruction:

```text
Use /home/workspace/Wiki/<client-slug>-wiki.
Run the equivalent of ./.ops/bin/weekly-digest.
Then send a short message in chat:
"Weekly digest is ready in outputs. Add one new source to raw this week."
```

## Success criteria

- A file exists: `outputs/<date>-weekly-digest.md`
- File includes changes from last 7 days
- Includes one specific next action
