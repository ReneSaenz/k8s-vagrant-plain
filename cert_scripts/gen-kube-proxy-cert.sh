#!/bin/bash

DIR_IN="cert_config_files"
DIR_OUT="certs_generated"

echo "***************************************"
echo "*** Generate kube-proxy certificate ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_IN/ca-config.json" \
-profile=kubernetes \
"$DIR_IN/kube-proxy-csr.json" | cfssljson -bare "$DIR_OUT/kube-proxy"

echo "***************************************"
echo "*** Verification for kube-proxy.pem ***"
openssl x509 -in "$DIR_OUT/kube-proxy.pem" -text -noout
