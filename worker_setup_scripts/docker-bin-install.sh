#!/bin/bash


dockerVersion="17.05.0-ce"

echo "*** install Docker ***"
wget --no-verbose https://get.docker.com/builds/Linux/x86_64/docker-"$dockerVersion".tgz
tar -xvf docker-"$dockerVersion".tgz
sudo cp docker/docker* /usr/bin/
