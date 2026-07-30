#!/bin/bash
set -euo pipefail

: "${REPOSITORY_URL:?Missing REPOSITORY_URL}"
: "${REPOSITORY_TOKEN:?Missing REPOSITORY_TOKEN}"

REPO=/data/repo

if [ ! -d "${REPO}/.git" ]; then
    echo "Cloning repository..."

    git -c http.extraHeader="Authorization: Bearer ${REPOSITORY_TOKEN}" \
        clone \
        "${REPOSITORY_URL}" \
        "${REPO}"
else
    echo "Updating repository..."

    git -C "${REPO}" \
        -c http.extraHeader="Authorization: Bearer ${REPOSITORY_TOKEN}" \
        fetch origin

    git -C "${REPO}" reset --hard origin/master
fi
