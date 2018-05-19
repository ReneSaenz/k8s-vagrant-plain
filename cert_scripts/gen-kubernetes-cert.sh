#!/bin/bash

# Generate the Kubernetes TLS certificate
# generate the kubernetes client certificate and private key
# Uses
# admin CA certificate signing request file in cert_config_files/kubernetes-csr.json

DIR_CERT="cert_config_files"
DIR_OUT="certs_generated"

echo "***************************************"
echo "*** Generate kubernetes certificate and private key ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_CERT/ca-config.json" \
-profile=kubernetes \
"$DIR_CERT/kubernetes-csr.json" | cfssljson -bare "$DIR_OUT/kubernetes"

echo "***************************************"
echo "*** Verification for kubernetes.pem ***"
openssl x509 -in "$DIR_OUT/kubernetes.pem" -text -noout
