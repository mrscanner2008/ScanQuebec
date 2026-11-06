#!/usr/bin/env bash
# Build BrowSDR and publish static assets into ./live_sdr_vendor/
# Run from anywhere; script lives at the repository root.
set -euo pipefail

REPO_URL="${1:-https://github.com/jLynx/BrowSDR.git}"
BRANCH="${2:-main}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${SCRIPT_DIR}"
WORK_DIR="${TMPDIR:-/tmp}/browsdr_build_scanqc"
OUT_DIR="${REPO_ROOT}/live_sdr_vendor"

command -v git >/dev/null || { echo "git required"; exit 1; }
command -v npm >/dev/null || { echo "npm required"; exit 1; }
command -v cargo >/dev/null || { echo "cargo (Rust) required"; exit 1; }

rm -rf "${WORK_DIR}"
mkdir -p "${WORK_DIR}"
cd "${WORK_DIR}"
git clone --depth 1 --branch "${BRANCH}" "${REPO_URL}" browsdr
cd browsdr
npm install
if [[ -d hackrf-web ]]; then
  (cd hackrf-web && cargo make build)
fi
npm run build

if [[ ! -d dist ]]; then
  echo "Build failed: dist/ not found"
  exit 1
fi

rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"
cp -R dist/* "${OUT_DIR}/"
echo "Done. BrowSDR published to ${OUT_DIR}"
echo "Open live_sdr.html — it will prefer live_sdr_vendor/ when present."
