#!/bin/bash

# The Kubelet can now use CNI - the Container Network Interface to manage machine level networking requirements.
# CNI https://github.com/containernetworking/cni


echo "*** create cni directories ***"
sudo mkdir -p /opt/cni
sudo mkdir -p /opt/cni/bin
sudo mkdir -p /etc/cni/net.d


echo "*** install CNI plugins ***"
# wget -q --no-verbose --https-only --timestamping \
wget --no-verbose --https-only  \
https://storage.googleapis.com/kubernetes-release/network-plugins/cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz

sudo tar -xvf cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -C /opt/cni
