# Perfect Pilot Runbook (Copy/Paste)

Use this when you want the cleanest possible first run with a non-technical client.

## Step 1 - Install

Run this in terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) <client-slug> /home/workspace/Wiki
```

Example:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) wife /home/workspace/Wiki
```

## Step 2 - Paste rule prompt into client Zo

Copy the entire file below and paste it to the client's Zo:

`/home/workspace/Wiki/<client-slug>-wiki/outputs/START-HERE-WIKI-RULE-PROMPT.md`

## Alternate mode - One-shot install + onboarding

If you want one paste that tells client Zo to install and immediately run onboarding, use:

`/home/workspace/Wiki/<client-slug>-wiki/outputs/START-HERE-ONE-SHOT-INSTALL-ONBOARD-PROMPT.md`

This replaces Steps 2-4.

## Step 3 - Paste kickoff message into client Zo

Copy the entire file below and paste it to the client's Zo:

`/home/workspace/Wiki/<client-slug>-wiki/outputs/START-HERE-NEXT-MESSAGE.md`

## Step 4 - After client replies "done"

Copy the entire file below and paste it to the client's Zo:

`/home/workspace/Wiki/<client-slug>-wiki/outputs/START-HERE-ONBOARDING-GAME-PROMPT.md`

## Step 5 - If confusion appears

Copy the plain-language help from:

`operator-pack/CLIENT-FAQ.md`

## Success definition

Pilot is successful when all are true:

1. Client added at least one source item.
2. `wiki/index.md` exists in the client vault.
3. `outputs/<today>-onboarding-answer.md` exists.
4. `outputs/<today>-weekly-digest.md` exists.
