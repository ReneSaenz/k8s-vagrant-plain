#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.11"

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=certs_generated/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
  --client-certificate=certs_generated/kube-proxy.pem \
  --client-key=certs_generated/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=kube-proxy \
  --kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=auth_generated/kube-proxy.kubeconfig
