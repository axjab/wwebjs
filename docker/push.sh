#!/usr/bin/env bash

set -euo pipefail

REGISTRY="ghcr.io/axjab"

echo -e "\033[1;34mPUSHING TO ${REGISTRY}/${PKG}:${VERSION}\033[0m"
sudo docker push "${REGISTRY}/${PKG}:${VERSION}"

echo -e "\033[1;34mPUSHING TO ${REGISTRY}/${PKG}:latest\033[0m"
sudo docker push "${REGISTRY}/${PKG}:latest"

echo
echo -e "\033[1;32m==================================================\033[0m"
echo -e "\033[1;32m PUSH COMPLETE - GHCR UPDATED\033[0m"
echo -e "\033[1;32m==================================================\033[0m"
