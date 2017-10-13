#!/bin/bash

adminToken=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')
kubeletToken=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > auth_generated/token.csv <<EOF
$adminToken,admin,admin,"cluster-admin,system:masters"
$kubeletToken,kubelet,kubelet,"cluster-admin,system:masters"
EOF

cat > auth_generated/kubeconfig  <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority: /var/lib/kubernetes/ca.pem
    server: https://127.0.0.1:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubelet
  name: kubelet
current-context: kubelet
users:
- name: kubelet
  user:
    token: $kubeletToken
EOF
