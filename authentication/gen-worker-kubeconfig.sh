#!/bin/bash

# This script assumes there are 3 named workers with IP
# worker1 - 192.68.50.101
# worker2 - 192.68.50.102
# worker3 - 192.68.50.103

KUBERNETES_PUBLIC_ADDRESS="192.68.50.11"

for worker in worker1 worker2 worker3; do
  kubectl config set-cluster k8s-the-hard-way \
    --certificate-authority=certs_generated/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=auth_generated/${worker}.kubeconfig

  kubectl config set-credentials system:node:${worker} \
    --client-certificate=certs_generated/${worker}.pem \
    --client-key=certs_generated/${worker}-key.pem \
    --embed-certs=true \
    --kubeconfig=auth_generated/${worker}.kubeconfig

  kubectl config set-context k8s-context \
    --cluster=k8s-the-hard-way \
    --user=system:node:${worker} \
    --kubeconfig=auth_generated/${worker}.kubeconfig

  kubectl config use-context k8s-context \
    --kubeconfig=auth_generated/${worker}.kubeconfig

done
