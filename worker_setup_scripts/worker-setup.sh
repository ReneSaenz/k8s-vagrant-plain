#!/bin/bash


WORKER_NAME=$1


echo "*** create /var/lib/{kubelet,kube-proxy,kubernetes} ***"
sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}

echo "*** mv ca.pem /var/lib/kubernetes ***"
sudo mv ca.pem /var/lib/kubernetes/

# echo "*** mv kubernetes.pem /var/lib/kubernetes ***"
# sudo mv kubernetes.pem /var/lib/kubernetes/

# echo "*** mv kubernetes-key.pem /var/lib/kubernetes ***"
# sudo mv kubernetes-key.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.pem /var/lib/kubelet ***"
sudo mv kube-proxy.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.pem /var/lib/kubelet ***"
sudo mv kube-proxy-key.pem /var/lib/kubernetes/

echo "*** mv kube-proxy.kubeconfig /var/lib/kubelet ***"
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig

sudo mv "$WORKER_NAME".pem /var/lib/kubelet/
sudo mv "$WORKER_NAME"-key.pem /var/lib/kubelet/
