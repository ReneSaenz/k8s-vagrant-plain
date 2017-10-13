#!/bin/bash


ETCD_NAME=$1
WORKER_IP=$2
ETCD1_IP=$3
ETCD2_IP=$4
ETCD3_IP=$5

echo "*** Configure and install etcd service ***"

cat > etcd.service <<"EOF"
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/bin/etcd \
  --name ETCD_NAME \
  --cert-file=/etc/etcd/kubernetes.pem \
  --key-file=/etc/etcd/kubernetes-key.pem \
  --peer-cert-file=/etc/etcd/kubernetes.pem \
  --peer-key-file=/etc/etcd/kubernetes-key.pem \
  --trusted-ca-file=/etc/etcd/ca.pem \
  --peer-trusted-ca-file=/etc/etcd/ca.pem \
  --initial-advertise-peer-urls https://WORKER_IP:2380 \
  --listen-peer-urls https://WORKER_IP:2380 \
  --listen-client-urls https://WORKER_IP:2379,http://127.0.0.1:2379 \
  --advertise-client-urls https://WORKER_IP:2379 \
  --initial-cluster-token etcd-cluster \
  --initial-cluster etcd1=https://ETCD1_IP:2380,etcd2=https://ETCD2_IP:2380,etcd3=https://ETCD3_IP:2380 \
  --initial-cluster-state new \
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# --election-timeout=5000 \
# -–heartbeat-interval=250 \

sed -i s/ETCD_NAME/$ETCD_NAME/g etcd.service
sed -i s/WORKER_IP/$WORKER_IP/g etcd.service
sed -i s/ETCD1_IP/$ETCD1_IP/g etcd.service
sed -i s/ETCD2_IP/$ETCD2_IP/g etcd.service
sed -i s/ETCD3_IP/$ETCD3_IP/g etcd.service


# sudo rm /etc/systemd/system/etcd.service
sudo mv etcd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd
#sudo systemctl status etcd --no-pager
