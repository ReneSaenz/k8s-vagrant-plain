#!/bin/bash

AUTH_DIR="auth_generated"
CERT_DIR="certs_generated"
KUBERNETES_PUBLIC_ADDRESS="192.168.50.10"

# Create the kube-proxy kubeconfig
kubectl config set-cluster local-vagrant-cluster \
--certificate-authority=${CERT_DIR}/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
--kubeconfig=${AUTH_DIR}/kube-proxy.kubeconfig


kubectl config set-credentials kube-proxy \
--client-certificate=${CERT_DIR}/kube-proxy.pem \
--client-key=${CERT_DIR}/kube-proxy-key.pem \
--embed-certs=true \
--kubeconfig=${AUTH_DIR}/kube-proxy.kubeconfig


kubectl config set-context k8s-context \
--cluster=local-vagrant-cluster \
--user=kube-proxy \
--kubeconfig=${AUTH_DIR}/kube-proxy.kubeconfig

kubectl config use-context k8s-context \
--kubeconfig=${AUTH_DIR}/kube-proxy.kubeconfig
