#!/bin/bash

echo "*** create /var/lib/kubernetes ***"
sudo mkdir -p /var/lib/kubernetes/

echo "*** move token to /var/lib/kubernetes ***"
sudo mv token.csv /var/lib/kubernetes/
sudo mv encryption-config.yml /var/lib/kubernetes/

echo "*** moving certificates to /var/lib/kubernetes ***"
sudo mv ca.pem ca-key.pem kubernetes.pem kubernetes-key.pem /var/lib/kubernetes/

echo "*** download and install kube-apiserver ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kube-apiserver

echo "*** download and install kube-controller-manager ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kube-controller-manager

echo "*** download and install kube-scheduler ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kube-scheduler

echo "*** download and install kube-kubectl ***"
wget --no-verbose https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl

echo "*** install kubernetes binaries ***"
chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/bin/
