#!/bin/bash


k8sVersion="v1.6.4"

echo "*** download kube-proxy ***"

wget --no-verbose --https-only  \
https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kube-proxy


echo "*** install worker-node binaries ***"
chmod +x kube-proxy 
sudo mv kube-proxy /usr/bin/
