#!/bin/bash

echo "*** install Docker 1.12 ***"
wget --no-verbose https://get.docker.com/builds/Linux/x86_64/docker-1.12.6.tgz
tar -xvf docker-1.12.6.tgz
sudo cp docker/docker* /usr/bin/

echo "*** install CNI plugins ***"
sudo mkdir -p /opt/cni
wget --no-verbose https://storage.googleapis.com/kubernetes-release/network-plugins/cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz
sudo tar -xvf cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -C /opt/cni

#wget https://storage.googleapis.com/kubernetes-release/network-plugins/cni-07a8a28637e97b22eb8dfe710eeae1344f69d16e.tar.gz
#sudo tar -xvf cni-07a8a28637e97b22eb8dfe710eeae1344f69d16e.tar.gz -C /opt/cni

echo "*** download kubectl ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl


echo "*** download kube-proxy ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kube-proxy


echo "*** download kubectl ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubelet


chmod +x kubectl kube-proxy kubelet
sudo mv kubectl kube-proxy kubelet /usr/bin/

sudo mkdir -p /var/lib/kubelet
