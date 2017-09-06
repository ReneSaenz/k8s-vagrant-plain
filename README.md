# Kubernetes the hard way using a local vagrant setup

This setup follows [Kubernetes the hard way](https://github.com/kelseyhightower/kubernetes-the-hard-way)

## Cluster info

- Kubernetes 1.6.4
- Docker 1.12.6
- etcd 3.1.4
- Secure communication between all components (etcd, controllers, workers)

### What is missing
Since this is a local vagrant setup, no DNS and LB is setup.

- [Kubernetes addons](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
- Logging


## Execution

1. Clone this repo and move into it<br> `git clone https://github.com/ReneSaenz/k8s-vagrant-plain.git && cd k8s-vagrant-plain`
2. Run script to generate certificates `sh generate-certs.sh`
3. Run `vagrant up`
4. After all the nodes are up and provisioned, run script for remote login<br>`sh authentication/remote-cluster-access.sh`

At this point, you should be able to connecto securely to the kubernetes cluster
```
kubectl get componentstatuses

NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok                   
scheduler            Healthy   ok                   
etcd-2               Healthy   {"health": "true"}   
etcd-0               Healthy   {"health": "true"}   
etcd-1               Healthy   {"health": "true"}  

```


```
kubectl get nodes

NAME      STATUS    AGE  
node1     Ready     7m   
node2     Ready     5m   
node3     Ready     2m   
```

## Cluster commands

- [etcd commands](cluster_commands/etcd_commands.md)
- [kubectl commands](cluster_commands/kubectl_commands.md)
