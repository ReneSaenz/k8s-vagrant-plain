#!/bin/bash

sudo mkdir -p /opt/cni

sudo mkdir -p /var/lib/kubelet

echo "*** create /var/lib/kubernetes ***"
sudo mkdir -p /var/lib/kubernetes

echo "*** move certificates to /var/lib/kubernetes ***"
sudo cp ca.pem kubernetes-key.pem kubernetes.pem /var/lib/kubernetes/
