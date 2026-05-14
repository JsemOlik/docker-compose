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

mkdir -p letsencrypt
mkdir -p dynamic
touch letsencrypt/acme.json
run_priv chown 0:0 letsencrypt/acme.json
run_priv chmod 600 letsencrypt/acme.json
run_priv chmod 700 letsencrypt
run_priv chmod 755 dynamic

echo "traefik volumes prepared"
