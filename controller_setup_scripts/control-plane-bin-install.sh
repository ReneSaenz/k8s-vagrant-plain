#!/bin/bash

k8sVersion="v1.6.4"
# k8sVersion="v1.7.4"
# k8sVersion="v1.8.0"

echo "*** download and install kube-kubectl ***"
wget -q --no-verbose --https-only --timestamping \
"https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin/

echo "*** download and install kubernetes control plane binaries ***"
echo "*** download binary kube-apiserver ***"
wget -q --no-verbose --https-only --timestamping \
"https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kube-apiserver"

echo "*** download binary kube-controller-manager ***"
wget -q --no-verbose --https-only --timestamping \
"https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kube-controller-manager"

echo "*** download binary kube-scheduler ***"
wget -q --no-verbose --https-only --timestamping \
"https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kube-scheduler"

echo "*** install kubernetes binaries ***"
chmod +x kube-apiserver kube-controller-manager kube-scheduler
sudo mv kube-apiserver kube-controller-manager kube-scheduler /usr/bin/
