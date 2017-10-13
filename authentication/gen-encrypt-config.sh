#!/bin/bash

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
OUT_DIR="auth_generated"
cat > ${OUT_DIR}/encryption-config.yml <<EOF
apiVersion: v1
kind: EncryptionConfig
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

# cat > auth_generated/token.csv <<EOF
# ${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
# EOF
