#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS="192.68.50.11"

kubectl config set-cluster k8s-the-hard-way \
--certificate-authority=certs_generated/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
--kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
--client-certificate=certs_generated/kube-proxy.pem \
--client-key=certs_generated/kube-proxy-key.pem \
--embed-certs=true \
--kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config set-context k8s-context \
--cluster=k8s-the-hard-way \
--user=kube-proxy \
--kubeconfig=auth_generated/kube-proxy.kubeconfig

kubectl config use-context k8s-context \
--kubeconfig=auth_generated/kube-proxy.kubeconfig
