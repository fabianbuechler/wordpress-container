#!/usr/bin/env bash
set -ae

function cleanup {
  docker-compose down --rmi all
}
trap cleanup EXIT

docker-compose up --build
