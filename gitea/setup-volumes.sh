#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [ -f .env ]; then
  # shellcheck disable=SC1091
  source .env
fi

GITEA_UID="${USER_UID:-1000}"
GITEA_GID="${USER_GID:-1000}"

run_priv() {
  if [ "${EUID:-$(id -u)}" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    "$@"
  fi
}

mkdir -p gitea-data postgres-data

run_priv chown -R "${GITEA_UID}:${GITEA_GID}" gitea-data
run_priv chmod -R 775 gitea-data

# postgres official image default uid/gid
run_priv chown -R 999:999 postgres-data
run_priv chmod -R 775 postgres-data

echo "gitea volumes prepared"
