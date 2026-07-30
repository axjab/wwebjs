#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

REGISTRY="ghcr.io/axjab"

# add/remove --no-cache based on need to rebuild from scratch or not
  # --no-cache \
sudo docker build \
  --build-arg VERSION="$VERSION" \
  -t "$REGISTRY/${PKG}:${VERSION}" \
  -t "$REGISTRY/${PKG}:latest" \
  "$PROJECT_ROOT"

echo
echo -e "\033[1;33m==================================================\033[0m"
echo -e "\033[1;33m BUILD COMPLETE - REMEMBER TO PUSH TO GHCR\033[0m"
echo -e "\033[1;33m==================================================\033[0m"
