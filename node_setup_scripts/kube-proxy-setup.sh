#!/bin/bash

cat > kube-proxy.service <<"EOF"
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-proxy \
  --cluster-cidr=10.200.0.0/16 \
  --masquerade-all=true \
  --kubeconfig=/var/lib/kube-proxy/kube-proxy.kubeconfig \
  --proxy-mode=iptables \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sudo mv kube-proxy.service /etc/systemd/system/kube-proxy.service
sudo systemctl daemon-reload
sudo systemctl enable kube-proxy
sudo systemctl start kube-proxy
#sudo systemctl status kube-proxy --no-pager
