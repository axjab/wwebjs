#!/bin/bash
set -euo pipefail

: "${REPOSITORY_URL:?Missing REPOSITORY_URL}"
: "${REPOSITORY_TOKEN:?Missing REPOSITORY_TOKEN}"

REPO=/plugins

echo "$REPOSITORY_URL"
echo "$REPOSITORY_TOKEN"

if [ ! -d "${REPO}/.git" ]; then
    echo "Cloning plugins repository..."
    git clone "https://x-access-token:${REPOSITORY_TOKEN}@${REPOSITORY_URL#https://}" "${REPO}"
else
    echo "Updating plugins repository..."
    git -C "${REPO}" fetch origin
    git -C "${REPO}" reset --hard origin/master
fi
