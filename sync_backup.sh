#!/usr/bin/env bash
set -ae

source ./.env

# Sync all wordpress content files in wp-content/
echo ">>> Synchronize wp-content/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/wp-content/* \
    data/wp-content/
echo "Done"

# Configure database access for mysqldump
echo ">>> Configure DB access"
MYSQL_DEFAULTS_FILE=${WORDPRESS_DIR}/db-backup/mysql.cnf
scp mysql.cnf ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/db-backup/mysql.cnf
echo "Done"

# Dump wordpress database from mariadb
echo ">>> Create database dump"
ssh ${SSH_USER}@${SSH_HOST} \
    "mkdir -p ${WORDPRESS_DIR}/db-backup/"
ssh ${SSH_USER}@${SSH_HOST} \
    "mysqldump --defaults-file=${MYSQL_DEFAULTS_FILE} ${MYSQL_DATABASE} > ${WORDPRESS_DIR}/db-backup/backup_${MYSQL_DATABASE}.sql && rm ${MYSQL_DEFAULTS_FILE}"
echo "Done"

# Sync database backup
echo ">>> Synchronize db-backup/ directory"
rsync --recursive --links --times --devices --specials --delete --progress \
    ${SSH_USER}@${SSH_HOST}:${WORDPRESS_DIR}/db-backup/* \
    data/db-backup/
echo "Done"

echo ">>> Clean old docker volumes / images"
docker-compose down --rmi all
old_volumes=$(docker volume ls --filter="name=wordpress-container" -q)
if [[ -n "${old_volumes}" ]]; then
    docker volume rm ${old_volumes}
fi

echo ">>> Rebuild docker images for DB and wordpress"
docker-compose build

echo ">>> Finished"
