#!/bin/bash

# This script assumes there are 3 named workers with IP
# worker1 - 192.68.50.101
# worker2 - 192.68.50.102
# worker3 - 192.68.50.103

OUT_DIR="auth_generated"
CERT_DIR="certs_generated"
KUBERNETES_PUBLIC_ADDRESS="192.68.50.11"

for worker in worker1 worker2 worker3; do
  kubectl config set-cluster k8s-the-hard-way \
    --certificate-authority=${CERT_DIR}/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${OUT_DIR}/${worker}.kubeconfig

  kubectl config set-credentials system:node:${worker} \
    --client-certificate=${CERT_DIR}/${worker}.pem \
    --client-key=${CERT_DIR}/${worker}-key.pem \
    --embed-certs=true \
    --kubeconfig=${OUT_DIR}/${worker}.kubeconfig

  kubectl config set-context k8s-context \
    --cluster=k8s-the-hard-way \
    --user=system:node:${worker} \
    --kubeconfig=${OUT_DIR}/${worker}.kubeconfig

  kubectl config use-context k8s-context \
    --kubeconfig=${OUT_DIR}/${worker}.kubeconfig

done
