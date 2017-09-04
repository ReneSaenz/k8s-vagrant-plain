#!/bin/bash

BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > auth_generated/bootstrap_token <<EOF
${BOOTSTRAP_TOKEN}
EOF

cat > auth_generated/token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.11"

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=certs_generated/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=auth_generated/bootstrap.kubeconfig

kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=auth_generated/bootstrap.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=kubelet-bootstrap \
  --kubeconfig=auth_generated/bootstrap.kubeconfig

kubectl config use-context default --kubeconfig=authentication/bootstrap.kubeconfig
