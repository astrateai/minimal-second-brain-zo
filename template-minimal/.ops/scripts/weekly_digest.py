#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path


def recent_files(directory: Path, since: dt.datetime) -> list[Path]:
    out: list[Path] = []
    if not directory.exists():
        return out
    for p in directory.glob("*"):
        if not p.is_file():
            continue
        mtime = dt.datetime.utcfromtimestamp(p.stat().st_mtime)
        if mtime >= since:
            out.append(p)
    return sorted(out, key=lambda x: x.stat().st_mtime, reverse=True)


def to_bullets(paths: list[Path], root: Path, max_items: int = 5) -> list[str]:
    bullets: list[str] = []
    for p in paths[:max_items]:
        rel = p.relative_to(root)
        bullets.append(f"- `{rel}`")
    if not bullets:
        bullets.append("- None this week.")
    return bullets


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate a weekly digest for the vault.")
    parser.add_argument("--vault", required=True, help="Path to vault root")
    args = parser.parse_args()

    vault = Path(args.vault).resolve()
    raw_dir = vault / "raw"
    wiki_dir = vault / "wiki"
    outputs_dir = vault / "outputs"
    outputs_dir.mkdir(parents=True, exist_ok=True)

    now = dt.datetime.utcnow()
    since = now - dt.timedelta(days=7)

    raw_recent = recent_files(raw_dir, since)
    wiki_recent = recent_files(wiki_dir, since)
    outputs_recent = [p for p in recent_files(outputs_dir, since) if "weekly-digest" not in p.name]

    date_stamp = now.strftime("%Y-%m-%d")
    out_path = outputs_dir / f"{date_stamp}-weekly-digest.md"

    lines = [
        "# Weekly Digest",
        "",
        f"- Period: {since.strftime('%Y-%m-%d')} to {now.strftime('%Y-%m-%d')} (UTC)",
        f"- Raw files added: {len(raw_recent)}",
        f"- Wiki files updated: {len(wiki_recent)}",
        f"- Output files generated: {len(outputs_recent)}",
        "",
        "## What changed",
        "",
        "### New raw inputs",
        *to_bullets(raw_recent, vault),
        "",
        "### Updated wiki pages",
        *to_bullets(wiki_recent, vault),
        "",
        "### Outputs created",
        *to_bullets(outputs_recent, vault),
        "",
        "## Suggested next action",
        "- Add one high-value source file to `raw/` and run compile.",
        "",
        "## Nudge",
        "- Reply with: `process my wiki` to keep momentum this week.",
        "",
    ]

    out_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Weekly digest written to {out_path}")


if __name__ == "__main__":
    main()
