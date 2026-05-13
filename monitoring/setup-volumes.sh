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

mkdir -p grafana-data prometheus-data

# Grafana default container user
run_priv chown -R 472:472 grafana-data
run_priv chmod -R 775 grafana-data

# Prometheus default container user (nobody)
run_priv chown -R 65534:65534 prometheus-data
run_priv chmod -R 775 prometheus-data

echo "monitoring volumes prepared"
