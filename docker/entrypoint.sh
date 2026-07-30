#!/bin/bash
set -euo pipefail

for script in /app/scripts/*.sh; do
    echo "Running ${script}"
    "${script}"
done
