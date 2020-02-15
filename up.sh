#!/usr/bin/env bash
set -e

source ./.env
source ./util.sh

banner "Starting DB container"
docker-compose -p wpc up --detach db 2>/dev/null
banner "Importing DB backup"
progress_bar 60 2 \
    'docker-compose -p wpc logs db | grep -Pzq "(?s)init process done.+ready for connections"'

banner "Starting Wordpress container"
docker-compose -p wpc up --detach wordpress 2>/dev/null
progress_bar 10 1 \
    'docker-compose -p wpc logs wordpress | grep -q "FOREGROUND"'

echo "  - Website: http://localhost:8080/"
echo "  - Admin:   http://localhost:8080/wp-admin/"
