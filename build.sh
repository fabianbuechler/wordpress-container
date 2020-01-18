#!/usr/bin/env bash
set -ae

echo ">>> Clean old docker volumes / images"
docker-compose down --rmi all
old_volumes=$(docker volume ls --filter="name=wordpress-container" -q)
if [[ -n "${old_volumes}" ]]; then
    docker volume rm ${old_volumes}
fi

echo ">>> Rebuild docker images for DB and wordpress"
docker-compose build

echo ">>> Finished"
