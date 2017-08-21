
### Constants
VAGRANT_API = "2"
CONTROLLER_CLUSTER_IP = "10.3.0.1"

CONTROLLER1_IP= "192.68.50.11"
CONTROLLER2_IP= "192.68.50.12"
CONTROLLER3_IP= "192.68.50.13"

ETCD1_NAME = "etcd1"
ETCD2_NAME = "etcd2"
ETCD3_NAME = "etcd3"
ETCD1_IP = "192.68.50.11"
ETCD2_IP = "192.68.50.12"
ETCD3_IP = "192.68.50.13"

NODE1_IP= "192.68.50.101"
NODE2_IP= "192.68.50.102"
NODE3_IP= "192.68.50.103"

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.10"


## Variables
$box = "ubuntu/xenial64"
$controller_cpus = 1
$controller_vm_memory = 2048

$node_count = 3
$node_cpus = 2
$node_vm_memory = 4096

##########################################
### Functions

def controller_transfer_certs(controller)
  controller.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  controller.vm.provision :file, :source => "certs_generated/ca-key.pem", :destination => "ca-key.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes.pem", :destination => "kubernetes.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes-key.pem", :destination => "kubernetes-key.pem"
  controller.vm.provision :file, :source => "auth_generated/token.csv", :destination => "token.csv"
end

def node_transfer_certs(node)
  node.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  node.vm.provision :file, :source => "certs_generated/kube-proxy.pem", :destination => "kube-proxy.pem"
  node.vm.provision :file, :source => "certs_generated/kube-proxy-key.pem", :destination => "kube-proxy-key.pem"
end

def node_transfer_kubeconfig_files(node)
  node.vm.provision :file, :source => "auth_generated/bootstrap.kubeconfig", :destination => "bootstrap.kubeconfig"
  node.vm.provision :file, :source => "auth_generated/kube-proxy.kubeconfig", :destination => "kube-proxy.kubeconfig"
end


##########################################
Vagrant.configure(VAGRANT_API) do |config|
  ## General configuration
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  #########################################
  ### Configure Controllers
  #########################################

  config.vm.define "controller1" do |controller|
    controller.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Controller1"
      vb.cpus = $controller_cpus
      vb.memory = $controller_vm_memory
    end

    ## VM box and hostname
    controller.vm.box = $box
    controller.vm.hostname = "k8Controller1"

    ## network config
    controller.vm.network :private_network, ip: CONTROLLER1_IP

    ## provision
    controller_transfer_certs(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-setup.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/api-server-setup.sh",
                 :args => [CONTROLLER1_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-controller-setup.sh",
                 :args => CONTROLLER1_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-scheduler-setup.sh",
                 :args => CONTROLLER1_IP
  end

  config.vm.define "controller1" do |controller|
    controller.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Controller1"
      vb.cpus = $controller_cpus
      vb.memory = $controller_vm_memory
    end

    ## VM box and hostname
    controller.vm.box = $box
    controller.vm.hostname = "k8Controller1"

    ## network config
    controller.vm.network :private_network, ip: CONTROLLER1_IP

    #accessing localhost:8080 will access port 80 on the guest machines
    controller.vm.network "forwarded_port", guest: 9090, host: 9090
    controller.vm.network "forwarded_port", guest: 80, host: 8080

    ## provision
    controller_transfer_certs(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-setup.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/api-server-setup.sh",
                 :args => [CONTROLLER1_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-controller-setup.sh",
                 :args => CONTROLLER1_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-scheduler-setup.sh",
                 :args => CONTROLLER1_IP
  end

  config.vm.define "controller2" do |controller|
    controller.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Controller2"
      vb.cpus = $controller_cpus
      vb.memory = $controller_vm_memory
    end

    ## VM box and hostname
    controller.vm.box = $box
    controller.vm.hostname = "k8Controller2"

    ## network config
    controller.vm.network :private_network, ip: CONTROLLER2_IP

    ## provision
    controller_transfer_certs(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-setup.sh",
                 :args => [ETCD2_NAME,CONTROLLER2_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/api-server-setup.sh",
                 :args => [CONTROLLER2_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-controller-setup.sh",
                 :args => CONTROLLER2_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-scheduler-setup.sh",
                 :args => CONTROLLER2_IP
  end

  config.vm.define "controller3" do |controller|
    controller.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Controller3"
      vb.cpus = $controller_cpus
      vb.memory = $controller_vm_memory
    end

    ## VM box and hostname
    controller.vm.box = $box
    controller.vm.hostname = "k8Controller3"

    ## network config
    controller.vm.network :private_network, ip: CONTROLLER3_IP

    ## provision
    controller_transfer_certs(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-setup.sh",
                 :args => [ETCD3_NAME,CONTROLLER3_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/api-server-setup.sh",
                 :args => [CONTROLLER3_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-controller-setup.sh",
                 :args => CONTROLLER3_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/kube-scheduler-setup.sh",
                 :args => CONTROLLER3_IP
  end



  #########################################
  ### Configure nodes
  #########################################

  config.vm.define "node1" do |node|
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Node1"
      vb.cpus = $node_cpus
      vb.memory = $node_vm_memory
    end

    ## VM hostname
    node.vm.box = $box
    node.vm.hostname = "k8Node1"

    ## Network config
    node.vm.network :private_network, ip: NODE1_IP

    ## provision
    node_transfer_certs(node)
    node_transfer_kubeconfig_files(node)
    node.vm.provision :shell, :path => "node_setup_scripts/node-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/node-bin-install.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/docker-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/kube-proxy-setup.sh"
    node.vm.provision :shell,
                      :path => "node_setup_scripts/kubelet-setup.sh",
                      :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

  end

  config.vm.define "node2" do |node|
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Node2"
      vb.cpus = $node_cpus
      vb.memory = $node_vm_memory
    end

    ## VM hostname
    node.vm.box = $box
    node.vm.hostname = "k8Node2"

    ## Network config
    node.vm.network :private_network, ip: NODE2_IP

    ## provision
    node_transfer_certs(node)
    node_transfer_kubeconfig_files(node)
    node.vm.provision :shell, :path => "node_setup_scripts/node-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/node-bin-install.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/docker-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/kube-proxy-setup.sh"
    node.vm.provision :shell,
                      :path => "node_setup_scripts/kubelet-setup.sh",
                      :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

  end

  config.vm.define "node3" do |node|
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Node3"
      vb.cpus = $node_cpus
      vb.memory = $node_vm_memory
    end

    ## VM hostname
    node.vm.box = $box
    node.vm.hostname = "k8Node3"

    ## Network config
    node.vm.network :private_network, ip: NODE3_IP

    ## provision
    node_transfer_certs(node)
    node_transfer_kubeconfig_files(node)
    node.vm.provision :shell, :path => "node_setup_scripts/node-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/node-bin-install.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/docker-setup.sh"
    node.vm.provision :shell, :path => "node_setup_scripts/kube-proxy-setup.sh"
    node.vm.provision :shell,
                      :path => "node_setup_scripts/kubelet-setup.sh",
                      :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

  end

end
