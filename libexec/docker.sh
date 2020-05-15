#!/usr/bin/env bash
source /tmp/docker-virtualbox.env

exec ${DOCKER_CLI_BIN_PATH} "$@"
