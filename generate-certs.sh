#!/bin/bash

# remove previously generated certificates
if [ ! -e certs_generated ]; then
	mkdir -p certs_generated
fi

## delete previously generated certificates
rm -f certs_generated/*

## generate CA
sh cert_scripts/gen-ca.sh

## generate kubernetes certificate
sh cert_scripts/gen-kubernetes-cert.sh
