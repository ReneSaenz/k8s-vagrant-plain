#!/bin/bash

echo "*** Setting up kubelet service ***"

WORKER_NAME=$1

cat > kubelet.service <<"EOF"
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/kubelet \
  --api-servers=https://127.0.0.1:8080 \
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
  --cert-dir=/var/lib.kubelet \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sed -i s/WORKER_NAME/$WORKER_NAME/g kubelet.service


sudo mv kubelet.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl start kubelet
#sudo systemctl status kubelet --no-pager
