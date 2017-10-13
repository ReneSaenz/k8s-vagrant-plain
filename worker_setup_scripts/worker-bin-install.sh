#!/bin/bash

k8sVersion="v1.6.4"
# k8sVersion="v1.7.4"
cniVersion="v0.5.2"

echo "*** install CNI plugins ***"

sudo mkdir -p /opt/cni
sudo mkdir -p /etc/cni/net.d
wget --no-verbose https://github.com/containernetworking/cni/releases/download/"$cniVersion"/cni-amd64-"$cniVersion".tgz
sudo tar -xvf cni-amd64-"$cniVersion".tgz -C /opt/cni

echo "*** download kubectl ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kubectl

echo "*** download kube-proxy ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kube-proxy

echo "*** download kubelet ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kubelet

echo "*** install worker-node binaries ***"
chmod +x kubectl kube-proxy kubelet
sudo mv kubectl kube-proxy kubelet /usr/bin/
