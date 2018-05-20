#!/bin/bash


etcdVersion="v3.1.4"

echo "*** download etcd release binaries from coreos/etcd ***"
wget -q --no-verbose --https-only --timestamping \
"https://github.com/coreos/etcd/releases/download/"$etcdVersion"/etcd-"$etcdVersion"-linux-amd64.tar.gz"

echo "*** extract and install the etcd server binary and etcdctl cli ***"
tar -xvf etcd-"$etcdVersion"-linux-amd64.tar.gz
sudo mv etcd-"$etcdVersion"-linux-amd64/etcd* /usr/bin/
