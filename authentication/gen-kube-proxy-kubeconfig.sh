#!/bin/bash

OUT_DIR="auth_generated"
CERT_DIR="certs_generated"
KUBERNETES_PUBLIC_ADDRESS="192.68.50.11"

kubectl config set-cluster k8s-the-hard-way \
--certificate-authority=${CERT_DIR}/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
--kubeconfig=${OUT_DIR}/kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
--client-certificate=${CERT_DIR}/kube-proxy.pem \
--client-key=${CERT_DIR}/kube-proxy-key.pem \
--embed-certs=true \
--kubeconfig=${OUT_DIR}/kube-proxy.kubeconfig

kubectl config set-context k8s-context \
--cluster=k8s-the-hard-way \
--user=kube-proxy \
--kubeconfig=${OUT_DIR}/kube-proxy.kubeconfig

kubectl config use-context k8s-context \
--kubeconfig=${OUT_DIR}/kube-proxy.kubeconfig
