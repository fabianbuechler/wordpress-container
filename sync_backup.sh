#!/usr/bin/env bash
set -ae

source ./hosting.env

# Sync all wordpress content files in wp-content/
echo ">>> Synchronize wp-content/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WP_DIR}/wp-content/* \
    data/wp-content/
echo "Done"

# Configure database access for mysqldump
echo ">>> Configure DB access"
MYSQL_DEFAULTS_FILE=${WP_DIR}/db-backup/mysql.cnf
scp mysql.cnf ${SSH_USER}@${SSH_HOST}:${WP_DIR}/db-backup/mysql.cnf
echo "Done"

# Dump wordpress database from mariadb
echo ">>> Create database dump"
ssh ${SSH_USER}@${SSH_HOST} \
    "mkdir -p ${WP_DIR}/db-backup/"
ssh ${SSH_USER}@${SSH_HOST} \
    "mysqldump --defaults-file=${MYSQL_DEFAULTS_FILE} ${MYSQL_DATABASE} > ${WP_DIR}/db-backup/backup_$(date -I).sql && rm ${MYSQL_DEFAULTS_FILE}"
echo "Done"

# Sync database backup
echo ">>> Synchronize db-backup/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WP_DIR}/db-backup/* \
    data/db-backup/
echo "Done"

echo ">>> Finished"
