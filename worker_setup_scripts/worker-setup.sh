#!/bin/bash

sudo mkdir -p /opt/cni

sudo mkdir -p /var/lib/kubelet

echo "*** create /var/lib/kubernetes ***"
sudo mkdir -p /var/lib/kubernetes

echo "*** move certificates to /var/lib/kubernetes ***"
sudo cp ca.pem kubernetes.pem kubernetes-key.pem /var/lib/kubernetes/
