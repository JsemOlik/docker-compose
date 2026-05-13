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

mkdir -p config cache
run_priv chown -R "$(id -u):$(id -g)" config cache
run_priv chmod -R 775 config cache

echo "jellyfin volumes prepared"
