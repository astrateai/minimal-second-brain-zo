#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: load_sample_fixture.sh <client-vault-path>"
  echo "Example: load_sample_fixture.sh /home/workspace/Wiki/brother-wiki"
  exit 1
fi

VAULT="$(cd "$1" && pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

mkdir -p "${VAULT}/raw"
cp "${REPO_ROOT}/sample-fixture/raw/"* "${VAULT}/raw/"

echo "Loaded sample fixture into ${VAULT}/raw"
