#!/bin/bash

sudo mkdir -p /opt/cni

echo "*** create /var/lib/{kubelet,kube-proxy,kubernetes} ***"
sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}

sudo mkdir -p /var/lib/kubelet

echo "*** create /var/lib/kubernetes ***"
sudo mkdir -p /var/lib/kubernetes

echo "*** move certificates to /var/lib/kubernetes ***"
sudo cp ca.pem kubernetes.pem kubernetes-key.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.kubeconfig /var/lib/kubelet ***"
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/

echo "*** mv ca.pem /var/lib/kubernetes ***"
sudo mv ca.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.pem /var/lib/kubernetes ***"
sudo mv kube-proxy.pem /var/lib/kubernetes/

echo "*** kube-proxy-key.pem /var/lib/kubernetes ***"
sudo mv kube-proxy-key.pem /var/lib/kubernetes/
