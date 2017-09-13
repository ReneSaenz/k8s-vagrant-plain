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
  --allow-privileged=true \
  --cluster-dns=10.32.0.10 \
  --cluster-domain=cluster.local \
  --container-runtime=docker \
  --docker=unix:///var/run/docker/sock
  --network-plugin=kubenet \
  --experimental-bootstrap-kubeconfig=/var/lib/kubelet/bootstrap.kubeconfig \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --reconcile-cidr=true \
  --serialize-image-pulls=false \
  --image-pull-progress-deadline=2m \
  --register-node=true \
  --require-kubeconfig \
  --tls-cert-file=/var/lib/kubelet/${WORKER_NAME}.pem \\
  --tls-private-key-file=/var/lib/kubelet/${WORKER_NAME}-key.pem \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sed -i s/WORKER_NAME/$WORKER_NAME/g kubelet.service


sudo mv kubelet.service /etc/systemd/system/kubelet.service
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl start kubelet
#sudo systemctl status kubelet --no-pager
