# Kubernetes the hard way using a local vagrant setup

This setup follows [Kubernetes the hard way](https://github.com/kelseyhightower/kubernetes-the-hard-way)

## Cluster info

- Kubernetes 1.6.4
- Docker 1.12.6
- etcd 3.1.4

### What is missing
Since this is a local vagrant setup, no DNS and LB is setup.

- [Kubernetes addons](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
- Logging


## Execution

1. Run script to generate certificates `sh generate-certs.sh`
2. Run `vagrant up`
3. After all the nodes are up and provisioned, login to one of the controllers
and check the cluster.

```
$ vagrant ssh controller1
$ kubectl get cs
NAME                STATUS     MESSAGE                                                                    
controller-manager  Healthy    ok
scheduler           Healthy    ok
etcd-0              Unhealthy  Get https://192.68.50.11:2379/health: remote error: tls: bad certificate
etcd-2              Unhealthy  Get https://192.68.50.13:2379/health: remote error: tls: bad certificate
etcd-1              Unhealthy  Get https://192.68.50.12:2379/health: remote error: tls: bad certificate
```
4. Perform this only on the first controller. Enable TLS bootstrap by
binding the `kubelet-bootstrap` user to the `system:node-bootstrapper` cluster role

```
vagrant ssh controller1
kubectl create clusterrolebinding kubelet-bootstrap \
  --clusterrole=system:node-bootstrapper \
  --user=kubelet-bootstrap

clusterrolebinding "kubelet-bootstrap" created
```
5. Still inside controller1, list the pending certificate requests

```
kubectl get csr

NAME        AGE       REQUESTOR           CONDITION
csr-XXXXX   1m        kubelet-bootstrap   Pending
```
Approve **each** certificate signing request

```
kubectl certificate approve csr-XXXXX
certificatesigningrequest "csr-XXXXX" approved
```

Once all certificate signing requests have been approved all nodes should be registered with the cluster:

```
kubectl get nodes

NAME      STATUS    AGE       VERSION
node1     Ready     7m        v1.6.4
node2     Ready     5m        v1.6.4
node3     Ready     2m        v1.6.4
```

## Cluster commands

- [etcd commands](cluster_commands/etcd_commands.md)
- [kubectl commands](cluster_commands/kubectl_commands.md)
