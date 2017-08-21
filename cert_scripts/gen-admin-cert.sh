#!/bin/bash

DIR_IN="cert_config_files"
DIR_OUT="certs_generated"

echo "*** Generate admin-client certificate ***"
cfssl gencert \
-ca="$DIR_OUT/ca.pem" \
-ca-key="$DIR_OUT/ca-key.pem" \
-config="$DIR_IN/ca-config.json" \
-profile=kubernetes \
"$DIR_IN/admin-csr.json" | cfssljson -bare "$DIR_OUT/admin"


echo "*** Verification for admin.pem ***"
openssl x509 -in "$DIR_OUT/admin.pem" -text -noout
