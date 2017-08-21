#!/bin/bash

echo "*** create /var/lib/{kubelet,kube-proxy,kubernetes} ***"
sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}

echo "*** create /var/run/kubernetes ***"
sudo mkdir -p /var/run/kubernetes

echo "*** mv bootstrap.kubeconfig /var/lib/kubelet *** "
sudo mv bootstrap.kubeconfig /var/lib/kubelet

echo "*** mv ca.pem /var/lib/kubernetes ***"
sudo mv ca.pem /var/lib/kubernetes
