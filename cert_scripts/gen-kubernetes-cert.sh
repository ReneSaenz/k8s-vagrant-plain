#!/bin/bash

DIR_IN="cert_config_files"
DIR_OUT="certs_generated"

echo "*** Generate kubernetes certificate ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_IN/ca-config.json" \
-profile=kubernetes \
"$DIR_IN/kubernetes-csr.json" | cfssljson -bare "$DIR_OUT/kubernetes"

echo "*** Verification for kubernetes.pem ***"
openssl x509 -in "$DIR_OUT/kubernetes.pem" -text -noout
