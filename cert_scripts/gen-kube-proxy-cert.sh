#!/bin/bash


# generate the kube-proxy client certificate and private key
# Uses
# admin CA certificate signing request file in cert_config_files/kube-proxy-csr.json

DIR_CERT="cert_config_files"
DIR_OUT="certs_generated"

echo "***************************************"
echo "*** Generate kube-proxy certificate ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_CERT/ca-config.json" \
-profile=kubernetes \
"$DIR_CERT/kube-proxy-csr.json" | cfssljson -bare "$DIR_OUT/kube-proxy"

echo "***************************************"
echo "*** Verification for kube-proxy.pem ***"
openssl x509 -in "$DIR_OUT/kube-proxy.pem" -text -noout
