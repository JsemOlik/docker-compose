#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [ -f .env ]; then
  # shellcheck disable=SC1091
  source .env
fi

ELYTRA_UID="${ELYTRA_UID:-988}"
ELYTRA_GID="${ELYTRA_GID:-988}"

run_priv() {
  if [ "${EUID:-$(id -u)}" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    "$@"
  fi
}

mkdir -p mariadb-data panel-var panel-nginx panel-certs panel-logs elytra-data elytra-logs elytra-tmp elytra-config

# MariaDB default uid/gid
run_priv chown -R 999:999 mariadb-data
run_priv chmod -R 775 mariadb-data

# Panel paths can be touched by different users depending on image/runtime
run_priv chmod -R 777 panel-var panel-nginx panel-certs panel-logs

# Elytra runtime uid/gid comes from env
run_priv chown -R "${ELYTRA_UID}:${ELYTRA_GID}" elytra-data elytra-logs elytra-tmp elytra-config
run_priv chmod -R 775 elytra-data elytra-logs elytra-tmp elytra-config

echo "pyrodactyl volumes prepared"
