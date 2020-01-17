#!/usr/bin/env bash
set -exa

HOST=e15756@e15756-ssh.services.easyname.eu
WP_DIR=/data/web/e15756/html/apps/wordpress-97153
MYSQL_DATABASE=u8342db205
MYSQL_USER=u8342db205

# Sync all wordpress content files in wp-content/
rsync --recursive --links --times --devices --specials --delete --progress \
    ${HOST}:${WP_DIR}/wp-content/* \
    data/wp-content/

# Dump wordpress database from mariadb
ssh ${HOST} \
    "mkdir -p ${WP_DIR}/db-backup/"
ssh ${HOST} \
    "mysqldump -p -u ${MYSQL_USER} ${MYSQL_DATABASE} > ${WP_DIR}/db-backup/backup_$(date -I).sql"

# Sync database backup
rsync --recursive --links --times --devices --specials --delete --progress \
    ${HOST}:${WP_DIR}/db-backup/* \
    data/db-backup/
