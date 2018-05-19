#!/bin/bash


# generate the admin client certificate and private key
# Uses
# admin CA certificate signing request file in cert_config_files/admin-csr.json

DIR_CERT="cert_config_files"
DIR_OUT="certs_generated"

echo "*****************************************"
echo "*** Generate admin-client certificate and private key ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_CERT/ca-config.json" \
-profile=kubernetes \
"$DIR_CERT/admin-csr.json" | cfssljson -bare "$DIR_OUT/admin"

echo "**********************************"
echo "*** Verification for admin.pem ***"
openssl x509 -in "$DIR_OUT/admin.pem" -text -noout
