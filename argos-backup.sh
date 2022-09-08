#!/bin/bash

# A script to perform incremental backups using rsync
# Based on: https://linuxconfig.org/how-to-create-incremental-backups-using-rsync-on-linux

set -o errexit
set -o nounset
set -o pipefail

# Set these to configure source and backup dir
readonly SOURCE_DIR="${HOME}/Desktop/data"
readonly BACKUP_DIR="${HOME}/Desktop/backup"

readonly DATETIME="$(date +%s)"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"

rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude=".cache" \
  "${BACKUP_PATH}"

rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"

