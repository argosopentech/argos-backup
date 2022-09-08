#!/bin/bash

# A script to perform incremental backups using rsync
# Based on: https://linuxconfig.org/how-to-create-incremental-backups-using-rsync-on-linux

set -o errexit
set -o nounset
set -o pipefail

# Configure source and backup dir
# export ARGOS_BACKUP_SOURCE_DIR="${HOME}/Desktop/data"
# export ARGOS_BACKUP_DIR="${HOME}/git/argos-backup/"

readonly SOURCE_DIR=$ARGOS_BACKUP_SOURCE_DIR
readonly BACKUP_DIR="$ARGOS_BACKUP_DIR/backup"

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

