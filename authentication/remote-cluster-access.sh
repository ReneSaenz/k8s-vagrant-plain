#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.11"

kubectl config set-cluster k8s-the-hard-way \
  --certificate-authority=certs_generated/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \

kubectl config set-credentials admin --token chAng3m3

kubectl config set-context k8s-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin \

kubectl config use-context k8s-the-hard-way
