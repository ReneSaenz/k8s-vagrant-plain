#!/bin/bash

echo "*** create etcd directory /etc/etcd ***"
sudo mkdir -p /etc/etcd/

echo "*** copy certificates to /etc/etcd ***"
sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

echo "*** create etcd data dir  /var/lib/etcd ***"
sudo mkdir -p /var/lib/etcd

echo "*** download etcd release binaries from coreos/etcd ***"

wget --no-verbose https://github.com/coreos/etcd/releases/download/v3.1.4/etcd-v3.1.4-linux-amd64.tar.gz
tar -xvf etcd-v3.1.4-linux-amd64.tar.gz
sudo mv etcd-v3.1.4-linux-amd64/etcd* /usr/bin/
