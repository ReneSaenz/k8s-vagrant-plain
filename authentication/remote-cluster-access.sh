#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS="192.68.50.11"

kubectl config set-cluster k8s-the-hard-way \
--certificate-authority=certs_generated/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \


kubectl config set-credentials admin \
--client-certificate=certs_generated/admin.pem \
--client-key=certs_generated/admin-key.pem \

kubectl config set-context k8s-context \
--cluster=k8s-the-hard-way \
--user=admin \


kubectl config use-context k8s-context
