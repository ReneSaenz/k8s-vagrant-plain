#!/bin/bash

echo "*** install CNI plugins ***"
sudo mkdir -p /opt/cni

wget --no-verbose https://storage.googleapis.com/kubernetes-release/network-plugins/cni-07a8a28637e97b22eb8dfe710eeae1344f69d16e.tar.gz
sudo tar -xvf cni-07a8a28637e97b22eb8dfe710eeae1344f69d16e.tar.gz -C /opt/cni

echo "*** Download and install the Kubernetes worker binaries ***"

echo "*** download kubectl ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl

echo "*** download kube-proxy ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kube-proxy

echo "*** download kubelet ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubelet


chmod +x kubectl kube-proxy kubelet
sudo mv kubectl kube-proxy kubelet /usr/bin/

sudo mkdir -p /var/lib/kubelet
