#!/usr/bin/env bash
set -ae

function cleanup {
  docker-compose stop
}
trap cleanup EXIT

docker-compose up --build
