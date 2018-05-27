#!/bin/bash

k8sVersion="v1.6.4"

echo "*** download kubectl ***"
wget --no-verbose --https-only  \
https://storage.googleapis.com/kubernetes-release/release/"$k8sVersion"/bin/linux/amd64/kubectl

echo "*** install kubectl binaries ***"
chmod +x kubectl 
sudo mv kubectl /usr/bin/
