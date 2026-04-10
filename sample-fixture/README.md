# Sample Fixture

Use these files for a 2-minute validation.

## Load fixture into a client vault

```bash
cp sample-fixture/raw/* /home/workspace/Wiki/<client-slug>-wiki/raw/
```

Then run:

```bash
cd /home/workspace/Wiki/<client-slug>-wiki
./.ops/bin/compile
./.ops/bin/health-check
./.ops/bin/weekly-digest
```
