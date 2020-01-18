#!/usr/bin/env bash
set -ae

function cleanup {
  docker-compose down
}
trap cleanup EXIT

docker-compose up
