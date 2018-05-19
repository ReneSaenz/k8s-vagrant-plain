#!/bin/bash

# Generate Certificate Authority and private key

# Uses
# 1) CA configuration file in cert_config_files/ca-config.json
# 2) CA certificate signing request file in cert_config_files/ca-csr.json

DIR_CERT="cert_config_files"
DIR_OUT="certs_generated"

echo "**************************************"
echo "*** Generate Certificate Authority ***"
cfssl gencert -initca "$DIR_CERT/ca-csr.json" | cfssljson -bare "$DIR_OUT/ca"

echo "*******************************"
echo "*** Verification for ca.pem ***"
openssl x509 -in "$DIR_OUT/ca.pem" -text -noout
