## Prerequisites
We need to install client tools required to install and interact with kubernetes.<br>
Required tools are `cfssl`, `cfssljson` and `kubectl`

### Install CFSSL
The kubernetes cluster is secured by certificates. We are going to use self-signed certificates.
Download and install [ cloudflare cfssl/cfssljson](https://github.com/cloudflare/cfssl) from [cfssl repository](https://pkg.cfssl.org/)
The cfssl and cfssljson command line utilities will be used to provision a
[PKI Infrastructure](https://en.wikipedia.org/wiki/Public_key_infrastructure) and generate TLS certificates.

#### OSX
```
$ wget -q --show-progress --https-only --timestamping \
  https://pkg.cfssl.org/R1.2/cfssl_darwin-amd64 \
  https://pkg.cfssl.org/R1.2/cfssljson_darwin-amd64

$ chmod +x cfssl_darwin-amd64 cfssljson_darwin-amd64
$ sudo mv cfssl_darwin-amd64 /usr/local/bin/cfssl
$ sudo mv cfssljson_darwin-amd64 /usr/local/bin/cfssljson
```
#### Linux
```
$ wget -q --show-progress --https-only --timestamping \
  https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
  https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64

$ chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
$ sudo mv cfssl_linux-amd64 /usr/local/bin/cfssl
$ sudo mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
```

Verify `cfssl` version is 1.2.0 or higher is installed.
```
$ cfssl version
```

### Install kubectl
The `kubectl` command is used to interact with the Kubernetes API server.

#### OSX
```
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl

$ chmod +x kubectl
$ sudo mv kubectl /usr/local/bin/
```

#### Linux
```
$ wget https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl

$ chmod +x kubectl
$ sudo mv kubectl /usr/local/bin/
```

Verify `kubectl` version 1.7.4 or higher is installed.
```
$ kubectl version --client
```

Output
```
Client Version: version.Info{Major:"1", Minor:"7", GitVersion:"v1.7.4", GitCommit:"793658f2d7ca7f064d2bdf606519f9fe1229c381", GitTreeState:"clean", BuildDate:"2017-08-17T08:48:23Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"darwin/amd64"}
```
