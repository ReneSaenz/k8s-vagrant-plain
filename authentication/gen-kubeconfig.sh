#!/bin/bash

AUTH_DIR="auth_generated"
CERT_DIR="certs_generated"
KUBERNETES_PUBLIC_ADDRESS="192.168.50.10"

kubectl config set-cluster local-vagrant-cluster \
--certificate-authority=${CERT_DIR}/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
--kubeconfig=${AUTH_DIR}/bootstrap.kubeconfig

kubectl config set-credentials kubelet-bootstrap \
--token=${AUTH_DIR}/token.csv \
--kubeconfig=${AUTH_DIR}/bootstrap.kubeconfig

kubectl config set-context k8s-context \
--cluster=local-vagrant-cluster \
--user=kubelet-bootstrap \
--kubeconfig=${AUTH_DIR}/bootstrap.kubeconfig

kubectl config use-context k8s-context \
--kubeconfig=${AUTH_DIR}/kubelet-bootstrap
