#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

run_priv() {
  if [ "${EUID:-$(id -u)}" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    "$@"
  fi
}

mkdir -p data config

# Mercure container runtime user may vary by version; keep writable to avoid bind-mount issues.
run_priv chmod -R 777 data config

echo "mercure-hub volumes prepared"
