#!/usr/bin/env bash
set -euo pipefail
REPO_URL="${1:-https://github.com/jLynx/BrowSDR.git}"
BRANCH="${2:-main}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORK_DIR="/tmp/browsdr_build_scanqc"
OUT_DIR="${REPO_ROOT}/live_sdr_vendor"
rm -rf "${WORK_DIR}"
mkdir -p "${WORK_DIR}"
cd "${WORK_DIR}"
git clone --branch "${BRANCH}" "${REPO_URL}" browsdr
cd browsdr
npm install
cd hackrf-web
cargo make build
cd ..
npm run build
rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"
cp -R dist/* "${OUT_DIR}/"
echo "Done. BrowSDR published to ${OUT_DIR}"
