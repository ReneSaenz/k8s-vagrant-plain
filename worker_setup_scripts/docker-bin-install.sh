#!/bin/bash


# dockerVersion="17.05.0-ce"
dockerVersion="1.12.6"


echo "*** install Docker ***"
# wget -q --no-verbose --https-only --timestamping \
echo "*** download binary Docker 1.12 ***"
wget -q --no-verbose --https-only --timestamping \
https://get.docker.com/builds/Linux/x86_64/docker-"$dockerVersion".tgz

# wget https://get.docker.com/builds/Linux/x86_64/docker-1.12.6.tgz
echo "*** extract and install Docker ***"
tar -xvf docker-"$dockerVersion".tgz
sudo cp docker/docker* /usr/bin/
