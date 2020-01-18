#!/usr/bin/env bash
set -ae

echo ">>> Stop docker containers and networks"
docker-compose down
