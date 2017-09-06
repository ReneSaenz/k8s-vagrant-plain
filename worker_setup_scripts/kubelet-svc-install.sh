#!/bin/bash

CONTROLLER1_IP=$1
CONTROLLER2_IP=$2
CONTROLLER3_IP=$3


cat > kubelet.service <<"EOF"
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/kubelet \
  --allow-privileged=true \
  --api-servers=https://CONTROLLER1_IP:6443,https://CONTROLLER2_IP:6443,https://CONTROLLER3_IP:6443 \
  --cloud-provider= \
  --cluster-dns=10.32.0.10 \
  --cluster-domain=cluster.local \
  --configure-cbr0=true \
  --container-runtime=docker \
  --docker=unix:///var/run/docker.sock
  --network-plugin=kubenet \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --reconcile-cidr=true \
  --serialize-image-pulls=false \
  --tls-cert-file=/var/lib/kubelet/kubernetes.pem \
  --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \
  --v=2

Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sed -i s/CONTROLLER1_IP/$CONTROLLER1_IP/g kubelet.service
sed -i s/CONTROLLER2_IP/$CONTROLLER2_IP/g kubelet.service
sed -i s/CONTROLLER3_IP/$CONTROLLER3_IP/g kubelet.service


sudo mv kubelet.service /etc/systemd/system/kubelet.service
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl start kubelet
#sudo systemctl status kubelet --no-pager
