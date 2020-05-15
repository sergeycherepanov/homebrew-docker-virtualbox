#!/usr/bin/env bash

exec > /tmp/docker-virtualbox.log
exec 2>&1

DOCKER_MACHINE_DRIVER=${DOCKER_DRIVER-virtualbox}
DOCKER_MACHINE_MACHINE_NAME=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE_MEMORY=${DOCKER_MACHINE_NAME-4096}
DOCKER_MACHINE_DISK_SIZE=${DOCKER_MACHINE_DISK_SIZE}

if [[ -z ${DOCKER_MACHINE_DISK_SIZE} ]]; then
    if [[ $(df | grep '\/$' | awk '{print $2/1000}') -gt 200000 ]]; then
        DOCKER_MACHINE_DISK_SIZE="32000"
    else
        DOCKER_MACHINE_DISK_SIZE="16000"
    fi
fi

if [[ -z ${DOCKER_MACHINE_CPU_COUNT} ]]; then
    if [[ "Darwin" == "$(uname)" ]]; then
        DOCKER_MACHINE_CPU_COUNT=$(sysctl -n hw.ncpu | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} { print ceil($1*0.25) }')
    else
        DOCKER_MACHINE_CPU_COUNT=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} { print ceil($1*0.25) }')
    fi
fi

if [[ -z ${DOCKER_MACHINE_MEMORY_COUNT} ]]; then
    if [[ "Darwin" == "$(uname)" ]]; then
        DOCKER_MACHINE_MEMORY_COUNT=$(sysctl -n hw.memsize | awk '{ mem=($1 * 0.25 / 1024 / 1024 ); print int(mem > 4096 ? 4096 : mem) }')
    else
        DOCKER_MACHINE_MEMORY_COUNT=$(free -b | grep Mem | awk '{ mem=($2 * 0.25 / 1024 / 1024 ); print int(mem > 4096 ? 4096 : mem) }')
    fi
fi

docker-machine create --driver ${DOCKER_MACHINE_DRIVER} \
    --virtualbox-cpu-count ${DOCKER_MACHINE_CPU_COUNT} \
    --virtualbox-memory ${DOCKER_MACHINE_MEMORY_COUNT} \
    --virtualbox-disk-size ${DOCKER_MACHINE_DISK_SIZE}
    ${DOCKER_MACHINE_MACHINE_NAME}

docker-machine-nfs ${DOCKER_MACHINE_MACHINE_NAME}

# setup env
echo "DOCKER_CLI_BIN_PATH=\"$(brew --prefix docker-cli)/bin/docker-cli\"" > /tmp/docker-virtualbox.env
echo "DOCKER_MACHINE_MACHINE_NAME=\"${DOCKER_MACHINE_NAME}\"" >> /tmp/docker-virtualbox.env
docker-machine env ${DOCKER_MACHINE_MACHINE_NAME} >> /tmp/docker-virtualbox.env

function stop()
{
    docker-machine stop ${DOCKER_MACHINE_MACHINE_NAME}
}

trap stop SIGKILL
trap stop SIGTERM
trap stop SIGINT

while : ; do sleep 2; done
