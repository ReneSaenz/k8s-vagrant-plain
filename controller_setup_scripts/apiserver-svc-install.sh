#!/bin/bash


CONTROLLER_IP=$1
CONTROLLER1_IP=$2
CONTROLLER2_IP=$3
CONTROLLER3_IP=$4


echo "*** Configure and install kube-apiserver service ***"

cat > kube-apiserver.service <<"EOF"
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/GoogleCloudPlatform/kubernetes

[Service]
ExecStart=/usr/bin/kube-apiserver \
  --admission-control=NamespaceLifecycle,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota \
  --advertise-address=CONTROLLER_IP \
  --allow-privileged=true \
  --apiserver-count=3 \
  --audit-log-maxage=30 \
  --audit-log-maxbackup=3 \
  --audit-log-maxsize=100 \
  --audit-log-path=/var/lib/audit.log \
  --authorization-mode=RBAC \
  --bind-address=0.0.0.0 \
  --enable-swagger-ui=true \
  --client-ca-file=/var/lib/kubernetes/ca.pem \
  --etcd-cafile=/var/lib/kubernetes/ca.pem \
  --etcd-certfile=/var/lib/kubernetes/kubernetes.pem \
  --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \
  --etcd-servers=https://CONTROLLER1_IP:2379,https://CONTROLLER2_IP:2379,https://CONTROLLER3_IP:2379 \
  --event-ttl=1h \
  --insecure-bind-address=127.0.0.1 \
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \
  --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \
  --kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \
  --kubelet-https=true \
  --service-account-key-file=/var/lib/kubernetes/ca-key.pem \
  --service-cluster-ip-range=10.32.0.0/24 \
  --service-node-port-range=30000-32767 \
  --tls-ca-file=/var/lib/kubernetes/ca.pem \
  --tls-cert-file=/var/lib/kubernetes/kubernetes.pem \
  --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \
  --token-auth-file=/var/lib/kubernetes/token.csv \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF


sed -i s/CONTROLLER_IP/$CONTROLLER_IP/g kube-apiserver.service
sed -i s/CONTROLLER1_IP/$CONTROLLER1_IP/g kube-apiserver.service
sed -i s/CONTROLLER2_IP/$CONTROLLER2_IP/g kube-apiserver.service
sed -i s/CONTROLLER3_IP/$CONTROLLER3_IP/g kube-apiserver.service

sudo mv kube-apiserver.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable kube-apiserver
sudo systemctl start kube-apiserver
#sudo systemctl status kube-apiserver --no-pager
