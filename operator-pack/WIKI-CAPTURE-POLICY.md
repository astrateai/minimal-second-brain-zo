# Wiki Capture Policy (Exact)

Use this exact policy during client operation:

1. If message starts with `wiki:` -> capture the message (and attachments) to wiki pipeline.
2. If message includes `wiki this` -> capture the current item/thread to wiki pipeline.
3. If message includes `no wiki` -> do not capture this message.
4. If a file or link is shared in chat -> capture by default.
5. If content is added to `raw/` -> capture by default.
6. Regular chat with no trigger/file/link -> do not auto-capture.

Conflict priority:

1. `no wiki` overrides all other capture triggers.
2. explicit wiki commands override regular chat behavior.
3. file/link uploads auto-capture unless `no wiki` is present.
