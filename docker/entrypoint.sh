#!/bin/bash
set -euo pipefail

for script in /app/docker/scripts/*.sh; do
    echo "Running ${script}"
    "${script}"
done
