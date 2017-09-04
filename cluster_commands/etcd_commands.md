# ETCD Commands

__**NOTE:**__ These commands assume the node IPs from the `Vagrantfile` have not been changed.

### Check the cluster health
```
etcdctl --ca-file=/etc/etcd/ca.pem cluster-health
```
or

```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
cluster-health
```

### List the members of the etcd cluster
```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
member list
```


### Query/List __ALL__ the data stored in etcd
```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
ls / --recursive
```


### Make a new "test" dir
```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
mkdir /test
```


### Make key in "test" dir
```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
mk /test/key rock
```


### Query/Get the new key
```
sudo etcdctl  \
--cert-file=/etc/etcd/kubernetes.pem  \
--key-file=/etc/etcd/kubernetes-key.pem  \
--ca-file=/etc/etcd/ca.pem  \
--peers="https:192.68.50.11:2379,https://192.68.50.12:2379,https://192.68.50.13:2379"  \
get /test/key
```
