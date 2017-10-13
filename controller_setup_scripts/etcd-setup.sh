#!/bin/bash

echo "*** create etcd directory /etc/etcd ***"
sudo mkdir -p /etc/etcd/

echo "*** create etcd data dir  /var/lib/etcd ***"
sudo mkdir -p /var/lib/etcd

echo "*** copy certificates to /etc/etcd ***"
sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
