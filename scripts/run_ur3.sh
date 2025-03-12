#!/bin/bash
# Starts a interactive docker shell into a running docker compose ros container
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

containerName="ursim"
robotModel="UR3"
# Stop and remove if a container already exists
docker stop ${containerName} || true && docker rm ${containerName} || true && docker rmi ${containerName} || true

image_ursim='docker.io/universalrobots/ursim_cb3:latest'
docker pull $image_ursim

docker run \
    -it \
    --rm \
    --name=${containerName} \
    -e ROBOT_MODEL=${robotModel} \
    -p 6080:6080 \
    -p 5900:5900 \
    -p 502:502 \
    -p 29999:29999 \
    -p 30001-30004:30001-30004 \
    -p 40419:40419 \
    -p 50002:50002 \
    -v "$(pwd)/programs":"/ursim/programs.${robotModel}" \
    -v "$(pwd)/programs":"/ursim/programs" \
    -v "$(pwd)/programs":"/programs" \
    -v "$(pwd)/urcaps":"/urcaps" \
    -h ursim \
    --privileged \
    --cpus=2 \
    $image_ursim
