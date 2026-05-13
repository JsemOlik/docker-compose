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

mkdir -p data letsencrypt
run_priv chown -R 0:0 data letsencrypt
run_priv chmod -R 775 data letsencrypt

echo "nginx-proxy-manager volumes prepared"
