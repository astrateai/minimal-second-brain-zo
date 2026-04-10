#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path
import re


def extract_source_refs(text: str) -> list[str]:
    refs = re.findall(r"`raw/([^`]+)`", text)
    return refs


def main() -> None:
    parser = argparse.ArgumentParser(description="Run health checks on a second-brain vault.")
    parser.add_argument("--vault", required=True, help="Path to vault root")
    args = parser.parse_args()

    vault = Path(args.vault).resolve()
    raw_dir = vault / "raw"
    wiki_dir = vault / "wiki"
    outputs_dir = vault / "outputs"
    outputs_dir.mkdir(parents=True, exist_ok=True)

    wiki_pages = [p for p in wiki_dir.glob("*.md") if p.name != "index.md"]
    raw_files = {p.name for p in raw_dir.glob("*") if p.is_file()}

    unsupported: list[str] = []
    missing_sources: list[str] = []
    referenced_sources: set[str] = set()

    titles: dict[str, list[str]] = {}

    for page in wiki_pages:
        text = page.read_text(encoding="utf-8", errors="ignore")
        refs = extract_source_refs(text)
        if not refs:
            unsupported.append(page.name)
        for ref in refs:
            referenced_sources.add(ref)
            if ref not in raw_files:
                missing_sources.append(f"{page.name} -> raw/{ref}")

        first = next((ln.strip() for ln in text.splitlines() if ln.startswith("# ")), "# Untitled")
        title = first[2:].strip().lower()
        titles.setdefault(title, []).append(page.name)

    duplicates = [files for files in titles.values() if len(files) > 1]
    unreferenced_raw = sorted(raw_files - referenced_sources)

    today = dt.datetime.utcnow().strftime("%Y-%m-%d")
    out = outputs_dir / f"{today}-health-check.md"

    lines = [
        "# Health Check",
        "",
        f"- Timestamp (UTC): {dt.datetime.utcnow().isoformat()}Z",
        f"- Wiki pages checked: {len(wiki_pages)}",
        "",
        "## Unsupported Claims",
    ]
    if unsupported:
        lines.extend([f"- {name}" for name in unsupported])
    else:
        lines.append("- None detected.")

    lines.extend(["", "## Missing Source References"])
    if missing_sources:
        lines.extend([f"- {item}" for item in missing_sources])
    else:
        lines.append("- None detected.")

    lines.extend(["", "## Duplicate Topic Titles"])
    if duplicates:
        for dup in duplicates:
            lines.append(f"- {', '.join(dup)}")
    else:
        lines.append("- None detected.")

    lines.extend(["", "## Raw Files Not Referenced Yet"])
    if unreferenced_raw:
        lines.extend([f"- raw/{name}" for name in unreferenced_raw])
    else:
        lines.append("- None detected.")

    lines.append("")
    out.write_text("\n".join(lines), encoding="utf-8")
    print(f"Health check written to {out}")


if __name__ == "__main__":
    main()
