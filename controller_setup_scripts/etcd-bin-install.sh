#!/bin/bash

echo "*** download etcd release binaries from coreos/etcd ***"
wget --no-verbose https://github.com/coreos/etcd/releases/download/v3.1.4/etcd-v3.1.4-linux-amd64.tar.gz

echo "*** extract an dinstall the etcd server binary and etcdctl cli ***"
tar -xvf etcd-v3.1.4-linux-amd64.tar.gz
sudo mv etcd-v3.1.4-linux-amd64/etcd* /usr/bin/
