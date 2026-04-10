#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: remote_install.sh <client-slug> [target-root]"
  echo "Example: remote_install.sh brother /home/workspace/Wiki"
  exit 1
fi

CLIENT="$1"
TARGET_ROOT="${2:-/home/workspace/Wiki}"
REPO_URL="https://github.com/astrateai/minimal-second-brain-zo.git"
INSTALL_ROOT="/tmp/minimal-second-brain-zo"

if [ -d "$INSTALL_ROOT/.git" ]; then
  git -C "$INSTALL_ROOT" pull --ff-only
else
  rm -rf "$INSTALL_ROOT"
  git clone "$REPO_URL" "$INSTALL_ROOT"
fi

"$INSTALL_ROOT/operator-pack/scripts/install_and_kickoff.sh" "$CLIENT" "$TARGET_ROOT"
