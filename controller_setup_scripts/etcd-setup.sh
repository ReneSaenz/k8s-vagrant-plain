#!/bin/bash


ETCD_NAME=$1
NODE_IP=$2
ETCD1_IP=$3
ETCD2_IP=$4
ETCD3_IP=$5

cat > etcd.service <<"EOF"
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/bin/etcd \
  --name ${ETCD_NAME} \
  --cert-file=/etc/etcd/kubernetes.pem \
  --key-file=/etc/etcd/kubernetes-key.pem \
  --peer-cert-file=/etc/etcd/kubernetes.pem \
  --peer-key-file=/etc/etcd/kubernetes-key.pem \
  --trusted-ca-file=/etc/etcd/ca.pem \
  --peer-trusted-ca-file=/etc/etcd/ca.pem \
  --peer-client-cert-auth \
  --client-cert-auth \
  --initial-advertise-peer-urls https://NODE_IP:2380 \
  --listen-peer-urls https://NODE_IP:2380 \
  --listen-client-urls https://NODE_IP:2379,http://127.0.0.1:2379 \
  --advertise-client-urls https://NODE_IP:2379 \
  --initial-cluster-token etcd-cluster \
  --initial-cluster etcd=https://ETCD1_IP:2380,etcd2=https://ETCD2_IP:2380,etcd3=https://ETCD3_IP:2380 \
  --initial-cluster-state new \
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sed-i s/ETCD_NAME/$ETCD_NAME/g etcd.service
sed -i s/NODE_IP/$NODE_IP/g etcd.service
sed -i s/ETCD1_IP/$ETCD1_IP/g etcd.service
sed -i s/ETCD2_IP/$ETCD2_IP/g etcd.service
sed -i s/ETCD3_IP/$ETCD3_IP/g etcd.service


sudo rm /etc/systemd/system/etcd.service
sudo mv etcd.service /etc/systemd/system/etcd.service
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd
#sudo systemctl status etcd --no-pager
