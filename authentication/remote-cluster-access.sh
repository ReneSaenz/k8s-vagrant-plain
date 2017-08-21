#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.11"

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=certs_generated/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \


kubectl config set-credentials admin \
  --client-certificate=certs_generated/admin.pem \
  --client-key=certs_generated/admin-key.pem \

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin \


kubectl config use-context kubernetes-the-hard-way
