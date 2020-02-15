#!/usr/bin/env bash
set -e

source ./.env
source ./util.sh

banner "Removing Wordpress and DB containers"
docker-compose -p wpc stop
echo "  Done"
