#!/bin/bash

# remove previously generated certificates
if [ ! -e certs_generated ]; then
	mkdir -p certs_generated
else
	## delete previously generated certificates
  rm -f certs_generated/*
fi

## generate CA - Initialize certificate authority
sh cert_scripts/gen-ca.sh

## generate client and server TLS certificates
# generate the admin client certificate and private key
sh cert_scripts/gen-admin-cert.sh
# generate the kube-proxy client certificate and private key
sh cert_scripts/gen-kube-proxy-cert.sh
# generate the kubernetes cluster certificate and private key
sh cert_scripts/gen-kubernetes-cert.sh

#######################################################

### Client Authentication Configurations ###
## Create generated authentication directory

if [ ! -e auth_generated ]; then
	mkdir -p auth_generated
else
	### delete previously generated kubeconfig files
  rm -f auth_generated/*
fi

## generate the authentication token
echo "*** Generate Token ***"
sh authentication/gen-token.sh
echo "*** Generate kubelet kubeconfig ***"
sh authentication/gen-kubeconfig.sh
echo "*** Generate kube-proxy kubeconfig ***"
sh authentication/gen-kube-proxy-kubeconfig.sh
