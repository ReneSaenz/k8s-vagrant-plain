#!/bin/bash

BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > auth_generated/bootstrap_token <<EOF
${BOOTSTRAP_TOKEN}
EOF

cat > auth_generated/token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF
