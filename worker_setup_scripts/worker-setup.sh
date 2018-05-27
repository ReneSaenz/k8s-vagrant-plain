#!/bin/bash

echo "*** create /var/lib/{kubelet,kube-proxy,kubernetes} ***"
sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}

echo "*** mv ca.pem /var/lib/kubernetes ***"
sudo mv ca.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.pem /var/lib/kubelet ***"
sudo mv kube-proxy.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.kubeconfig /var/lib/kube-proxy ***"
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy

echo "*** mv bootstrap.kubeconfig /var/lib/kubelet ***"
sudo mv bootstrap.kubeconfig /var/lib/kubelet
