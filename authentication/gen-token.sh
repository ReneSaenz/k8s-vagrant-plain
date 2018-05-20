#!/bin/bash

# Generate the token
BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

# Save the token
cat > auth_generated/token <<EOF
${BOOTSTRAP_TOKEN}
EOF

# Generate the token file
cat > auth_generated/token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF
