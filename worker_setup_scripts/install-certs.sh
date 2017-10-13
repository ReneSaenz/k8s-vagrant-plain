#!/bin/bash

WORKER_NAME=$1

echo "*** move certificates to /var/lib/kubernetes ***"
sudo mv ca.pem kubernetes.pem kubernetes-key.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.kubeconfig /var/lib/kubelet ***"
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig

echo "*** mv kube-proxy.pem kube-proxy-key.pem /var/lib/kubernetes ***"
sudo mv kube-proxy.pem kube-proxy-key.pem /var/lib/kubernetes/


sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig
sudo mv {$WORKER_NAME}.pem /var/lib/kubelet
sudo mv {$WORKER_NAME}-key.pem /var/lib/kubelet
