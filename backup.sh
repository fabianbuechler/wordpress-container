#!/usr/bin/env bash
set -e

source ./.env
source ./util.sh

# Configure database access for mysqldump
banner "Configure DB access"
MYSQL_DEFAULTS_FILE=${WORDPRESS_DIR}/db-backup/mysql.cnf
rsync mysql.cnf ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/db-backup/
echo "  Done"

# Dump wordpress database from mariadb
banner "Create database dump"
ssh ${SSH_USER}@${SSH_HOST} \
    "mkdir -p ${WORDPRESS_DIR}/db-backup/"
ssh ${SSH_USER}@${SSH_HOST} \
    "mysqldump --defaults-file=${MYSQL_DEFAULTS_FILE} ${MYSQL_DATABASE} > ${WORDPRESS_DIR}/db-backup/backup_${MYSQL_DATABASE}.sql && rm ${MYSQL_DEFAULTS_FILE}"
echo "  Done"

# Sync all wordpress content files in wp-content/
banner "Synchronize wp-content/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/wp-content/ \
    data/wp-content/
echo "  Done"

# Sync database backup
banner "Synchronize db-backup/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/db-backup/ \
    data/db-backup/
echo "  Done"

banner "Finished"
