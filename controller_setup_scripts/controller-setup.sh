#!/bin/bash

echo "*** create /var/lib/kubernetes ***"
sudo mkdir -p /var/lib/kubernetes/

echo "*** move token to /var/lib/kubernetes ***"
sudo mv token.csv /var/lib/kubernetes/
sudo mv encryption-config.yml /var/lib/kubernetes/

echo "*** moving certificates to /var/lib/kubernetes ***"
sudo cp ca.pem ca-key.pem kubernetes.pem kubernetes-key.pem /var/lib/kubernetes/
