#!/bin/bash

# This script assumes there are 3 named workers with IP
# worker1 - 192.68.50.101
# worker2 - 192.68.50.102
# worker3 - 192.68.50.103

for worker in worker1 worker2 worker3; do
cat > certs_generated/${worker}-csr.json <<EOF
{
  "CN": "system:node:${worker}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Dallas",
      "O": "system:nodes",
      "OU": "k8s Cluster",
      "OU": "TX",
      "ST": "Texas"
    }
  ]
}
EOF

done



cfssl gencert \
-ca=certs_generated/ca.pem \
-ca-key=certs_generated/ca-key.pem \
-config=cert_config_files/ca-config.json \
-hostname=worker1,192.68.50.101 \
-profile=kubernetes \
certs_generated/worker1-csr.json | cfssljson -bare certs_generated/worker1



cfssl gencert \
-ca=certs_generated/ca.pem \
-ca-key=certs_generated/ca-key.pem \
-config=cert_config_files/ca-config.json \
-hostname=worker2,192.68.50.102 \
-profile=kubernetes \
certs_generated/worker2-csr.json | cfssljson -bare certs_generated/worker2



cfssl gencert \
-ca=certs_generated/ca.pem \
-ca-key=certs_generated/ca-key.pem \
-config=cert_config_files/ca-config.json \
-hostname=worker3,192.68.50.103 \
-profile=kubernetes \
certs_generated/worker3-csr.json | cfssljson -bare certs_generated/worker3
