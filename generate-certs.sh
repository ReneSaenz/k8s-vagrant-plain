#!/bin/bash

# remove previously generated certificates
if [ ! -e certs_generated ]; then
	mkdir -p certs_generated
else
	## delete previously generated certificates
  rm -f certs_generated/*
fi

## generate CA
sh cert_scripts/gen-ca.sh

## generate admin client certificate
sh cert_scripts/gen-admin-cert.sh

## generate worker certificates
sh cert_scripts/gen-worker-cert.sh

## generate kube-proxy certificate
sh cert_scripts/gen-kube-proxy-cert.sh

## generate kubernetes certificate
sh cert_scripts/gen-kubernetes-cert.sh

### Client Authentication Configurations ###
## Create generated authentication directory
## if it does not exists
if [ ! -e auth_generated ]; then
	mkdir -p auth_generated
else
	## delete previously generated kubeconfig files
  rm -f auth_generated/*
fi

## generate encryption configuration yaml file
sh authentication/gen-encrypt-config.sh

## generate the authentication token
sh authentication/gen-token.sh

## generate kubeconfig files
# sh authentication/gen-kubeconfig.sh
sh authentication/gen-worker-kubeconfig.sh
sh authentication/gen-kube-proxy-kubeconfig.sh
