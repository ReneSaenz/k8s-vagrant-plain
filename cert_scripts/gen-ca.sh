#!/bin/bash

DIR_IN="cert_config_files"
DIR_OUT="certs_generated"

echo "*** Generate Certificate Authority ***"
cfssl gencert -initca "$DIR_IN/ca-csr.json" | cfssljson -bare "$DIR_OUT/ca"

echo "*** Verification for ca.pem ***"
openssl x509 -in "$DIR_OUT/ca.pem" -text -noout
