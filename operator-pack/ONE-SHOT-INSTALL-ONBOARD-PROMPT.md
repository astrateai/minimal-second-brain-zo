# One-Shot Prompt For Client Zo

Copy this prompt into the client's Zo chat. If slug/paths are already specific, no edits are needed.

```text
Run this complete setup and onboarding flow with no extra prompts from me.

Client slug: <client-slug>
Target root: /home/workspace/Wiki

1) Run this terminal command first:
bash <(curl -fsSL https://raw.githubusercontent.com/astrateai/minimal-second-brain-zo/main/operator-pack/scripts/remote_install.sh) <client-slug> /home/workspace/Wiki

2) After install succeeds, enforce this capture behavior for this workspace:
- If a message starts with `wiki:`, capture that message and attachments into raw.
- If a message includes `wiki this`, capture the current item/thread into raw.
- If a message includes `no wiki`, do not capture that message.
- If a file or link is shared, capture it into raw by default.
- Regular chat with no file/link and no wiki command should not be auto-captured.
- Priority: `no wiki` overrides everything.

3) Immediately start onboarding in chat with this exact kickoff message:
Welcome to your 2nd Brain.
Purpose: you dump information once, and Zo organizes it so you can ask better questions later.

Your only job: send source material into raw.

Raw folder:
/home/workspace/Wiki/<client-slug>-wiki/raw

Fast ways to do that:
1) Upload a file to that folder.
2) Paste text directly in chat and say: "Save this to my raw folder."
3) Text Zo and say: "Save this note to my raw folder."

What gets saved to your wiki automatically:
- Any file or link you share in chat
- Any message that starts with: wiki:
- Any message that includes: wiki this

What does not get saved:
- Any message that includes: no wiki
- Regular chat with no file/link and no wiki command

When you've added your first item, reply: done

4) Continue onboarding automatically:
- Wait for user reply `done`.
- If user is confused, explain in plain language and help them add one item.
- After `done`, run this exact onboarding script logic:
  - Level 1: verify at least one file exists in `/home/workspace/Wiki/<client-slug>-wiki/raw`
  - Level 2: compile wiki from raw and verify `/home/workspace/Wiki/<client-slug>-wiki/wiki/index.md` exists
  - Level 3: ask one question about the uploaded content, answer from wiki, save to `/home/workspace/Wiki/<client-slug>-wiki/outputs/<today>-onboarding-answer.md`
  - Level 4: generate weekly digest file at `/home/workspace/Wiki/<client-slug>-wiki/outputs/<today>-weekly-digest.md`
- At each level, report PASS/FAIL and retry once on failure.

5) End with:
Onboarding complete: PASS ✅
Your only job is to keep dropping useful files into raw/, or use `wiki:` / `wiki this` in chat.
My job is to organize, answer, and keep nudging you weekly.
```
