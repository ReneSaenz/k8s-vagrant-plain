#!/bin/bash

echo "*** Setting up kubelet service ***"

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
  --api-servers=https://CONTROLLER1_IP:6443,https://CONTROLLER2_IP:6443,https://CONTROLLER3_IP:6443 \
  --allow-privileged=true \
  --cluster-dns=10.32.0.10 \
  --cluster-domain=cluster.local \
  --container-runtime=docker \
  --experimental-bootstrap-kubeconfig=/var/lib/kubelet/bootstrap.kubeconfig \
  --network-plugin=kubenet \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --serialize-image-pulls=false \
  --register-node=true \
  --tls-cert-file=/var/lib/kubelet/kubelet-client.crt \
  --tls-private-key-file=/var/lib/kubelet/kubelet-client.key \
  --cert-dir=/var/lib/kubelet \
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
