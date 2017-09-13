#!/bin/bash

echo "*** install Docker 1.12 ***"
wget --no-verbose https://get.docker.com/builds/Linux/x86_64/docker-1.12.6.tgz
tar -xvf docker-1.12.6.tgz
sudo cp docker/docker* /usr/bin/
