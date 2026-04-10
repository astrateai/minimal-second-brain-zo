#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: bootstrap_second_brain.sh <client-slug> <target-root>"
  echo "Example: bootstrap_second_brain.sh brother /home/workspace/Wiki"
  exit 1
fi

CLIENT="$1"
TARGET_ROOT="$2"
TARGET_DIR="${TARGET_ROOT}/${CLIENT}-wiki"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/template-minimal"

mkdir -p "${TARGET_DIR}/raw" "${TARGET_DIR}/wiki" "${TARGET_DIR}/outputs"
cp "${TEMPLATE_ROOT}/WIKI_SCHEMA.md" "${TARGET_DIR}/WIKI_SCHEMA.md"

if [ -d "${TEMPLATE_ROOT}/.ops" ]; then
  rm -rf "${TARGET_DIR}/.ops"
  cp -R "${TEMPLATE_ROOT}/.ops" "${TARGET_DIR}/.ops"
fi

echo "Created: ${TARGET_DIR}"
echo "End-user workflow: only add files to ${TARGET_DIR}/raw"
echo "Operator commands: ${TARGET_DIR}/.ops/bin/{compile,health-check,backup,weekly-digest}"
