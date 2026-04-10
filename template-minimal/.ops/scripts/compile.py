#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
from pathlib import Path
import re


def slugify(value: str) -> str:
    value = value.lower().strip()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    value = re.sub(r"-+", "-", value).strip("-")
    return value or "untitled"


def read_raw_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return path.read_text(encoding="latin-1", errors="ignore")


def summarize(text: str, max_lines: int = 6) -> list[str]:
    lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
    bullets: list[str] = []
    for ln in lines:
        if ln.startswith("#"):
            continue
        if len(ln) > 180:
            ln = ln[:177].rstrip() + "..."
        bullets.append(ln)
        if len(bullets) >= max_lines:
            break
    return bullets or ["No clear summary lines detected from source."]


def extract_title(path: Path, text: str) -> str:
    for ln in text.splitlines():
        if ln.startswith("#"):
            title = ln.lstrip("#").strip()
            if title:
                return title
    stem = path.stem
    stem = re.sub(r"^\d{4}-\d{2}-\d{2}-", "", stem)
    stem = stem.replace("-", " ").strip()
    return stem.title() if stem else "Untitled"


def write_topic_page(wiki_dir: Path, raw_file: Path, text: str) -> Path:
    title = extract_title(raw_file, text)
    slug = slugify(title)
    out = wiki_dir / f"{slug}.md"
    key_points = summarize(text)

    content = [
        f"# {title}",
        "",
        "## Summary",
        f"Auto-compiled from `{raw_file.name}`.",
        "",
        "## Key Points",
    ]
    content.extend([f"- {point}" for point in key_points])
    content.extend([
        "",
        "## Source References",
        f"- `raw/{raw_file.name}`",
        "",
    ])
    out.write_text("\n".join(content), encoding="utf-8")
    return out


def write_index(wiki_dir: Path, pages: list[Path]) -> None:
    lines = ["# Wiki Index", ""]
    for page in sorted(pages, key=lambda p: p.name):
        if page.name == "index.md":
            continue
        name = page.stem.replace("-", " ").title()
        lines.append(f"- [{name}](./{page.name})")
    lines.append("")
    (wiki_dir / "index.md").write_text("\n".join(lines), encoding="utf-8")


def write_run_log(outputs_dir: Path, processed: int) -> None:
    ts = dt.datetime.utcnow().strftime("%Y-%m-%d")
    log = outputs_dir / f"{ts}-compile-run.md"
    log.write_text(
        "\n".join(
            [
                "# Compile Run",
                "",
                f"- Timestamp (UTC): {dt.datetime.utcnow().isoformat()}Z",
                f"- Raw files processed: {processed}",
                "",
            ]
        ),
        encoding="utf-8",
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Compile raw sources into wiki pages.")
    parser.add_argument("--vault", required=True, help="Path to vault root")
    args = parser.parse_args()

    vault = Path(args.vault).resolve()
    raw_dir = vault / "raw"
    wiki_dir = vault / "wiki"
    outputs_dir = vault / "outputs"

    for d in (raw_dir, wiki_dir, outputs_dir):
        d.mkdir(parents=True, exist_ok=True)

    raw_files = sorted([p for p in raw_dir.iterdir() if p.is_file() and p.suffix.lower() in {".md", ".txt"}])
    generated: list[Path] = []

    for raw_file in raw_files:
        text = read_raw_text(raw_file)
        generated.append(write_topic_page(wiki_dir, raw_file, text))

    write_index(wiki_dir, generated)
    write_run_log(outputs_dir, len(raw_files))
    print(f"Compiled {len(raw_files)} raw files into {wiki_dir}")


if __name__ == "__main__":
    main()
