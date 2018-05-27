#!/bin/bash

k8sVersion="v1.6.4"

echo "*** download kubelet ***"
wget --no-verbose --https-only  \
https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kubelet

echo "*** install kubelet binary ***"
chmod +x kubelet
sudo mv kubelet /usr/bin/