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

mkdir -p appdata
run_priv chown -R "$(id -u):$(id -g)" appdata
run_priv chmod -R 775 appdata

echo "homarr volumes prepared"
