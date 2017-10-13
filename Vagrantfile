
### Constants
VAGRANT_API="2"
CONTROLLER_CLUSTER_IP="10.3.0.1"

CONTROLLER1_IP="192.68.50.11"
CONTROLLER2_IP="192.68.50.12"
CONTROLLER3_IP="192.68.50.13"

ETCD1_NAME="etcd1"
ETCD2_NAME="etcd2"
ETCD3_NAME="etcd3"
ETCD1_IP="192.68.50.11"
ETCD2_IP="192.68.50.12"
ETCD3_IP="192.68.50.13"

WORKER1_NAME="worker1"
WORKER2_NAME="worker2"
WORKER3_NAME="worker3"
WORKER1_IP="192.68.50.101"
WORKER2_IP="192.68.50.102"
WORKER3_IP="192.68.50.103"

KUBERNETES_PUBLIC_ADDRESS="192.68.50.10"


## Variables
$box = "ubuntu/xenial64"
$controller_cpus = 1
$controller_vm_memory = 1024

$worker_cpus = 2
$worker_vm_memory = 1024 #2048

##########################################
### Functions

def controller_transfer_certs(controller)
  controller.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  controller.vm.provision :file, :source => "certs_generated/ca-key.pem", :destination => "ca-key.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes.pem", :destination => "kubernetes.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes-key.pem", :destination => "kubernetes-key.pem"
end

def controller_transfer_token(controller)
  controller.vm.provision :file, :source => "auth_generated/token.csv", :destination => "token.csv"
end

def controller_transfer_encrypKey(controller)
  controller.vm.provision :file, :source => "auth_generated/encryption-config.yml", :destination => "encryption-config.yml"
end

def worker_transfer_certs(worker, worker_number)
  pem_file = "worker#{worker_number}.pem"
  pemKey_file = "worker#{worker_number}-key.pem"
  pem_source = "certs_generated/#{pem_file}"
  pemKey_source = "certs_generated/#{pemKey_file}"


  worker.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  worker.vm.provision :file, :source => "certs_generated/kube-proxy.pem", :destination => "kube-proxy.pem"
  worker.vm.provision :file, :source => "certs_generated/kube-proxy-key.pem", :destination => "kube-proxy-key.pem"

  worker.vm.provision :file, :source => pem_source, :destination => pem_file
  worker.vm.provision :file, :source => pemKey_source, :destination => pemKey_file
end

def worker_transfer_kubeconfig_files(worker, worker_number)
  config_file = "worker#{worker_number}.kubeconfig"
  source = "auth_generated/#{config_file}"
  worker.vm.provision :file, :source => source, :destination => config_file
  worker.vm.provision :file, :source => "auth_generated/kube-proxy.kubeconfig", :destination => "kube-proxy.kubeconfig"
end

def worker_move_certs(worker, worker_number)
  pem_file = "worker#{worker_number}.pem"
  pemKey_file = "worker#{worker_number}-key.pem"
  worker.vm.provision :shell, inline: "sudo mv #{pem_file} /var/lib/kubelet"
  worker.vm.provision :shell, inline: "sudo mv #{pemKey_file} /var/lib/kubelet"
end


##########################################
Vagrant.configure(VAGRANT_API) do |config|
  ## General configuration
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  config.vm.define "kube-lb" do |lb|
    lb.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "kube-lb"
      vb.cpus = 1
      vb.memory = 1024
    end

    lb.vm.box = $box
    lb.vm.hostname = "kube-lb"
    lb.vm.network :private_network, ip: KUBERNETES_PUBLIC_ADDRESS
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
    controller_transfer_token(controller)
    controller_transfer_encrypKey(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"
    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER1_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh"

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
    controller_transfer_token(controller)
    controller_transfer_encrypKey(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"
    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD2_NAME,CONTROLLER2_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]


    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER2_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh"


    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh"

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
    controller_transfer_token(controller)
    controller_transfer_encrypKey(controller)

    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"
    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD3_NAME,CONTROLLER3_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]


    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER3_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh"


    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh"

  end



  #########################################
  ### Configure workers
  #########################################

  config.vm.define "worker1" do |worker|
    worker.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Worker1"
      vb.cpus = $worker_cpus
      vb.memory = $worker_vm_memory
    end

    ## VM hostname
    worker.vm.box = $box
    worker.vm.hostname = "k8Worker1"

    ## Network config
    worker.vm.network :private_network, ip: WORKER1_IP

    ## provision
    worker_transfer_certs(worker, 1)
    worker_transfer_kubeconfig_files(worker, 1)
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-setup.sh",
                        :args => [WORKER1_NAME]
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [WORKER1_NAME]

  end

  config.vm.define "worker2" do |worker|
    worker.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Worker2"
      vb.cpus = $worker_cpus
      vb.memory = $worker_vm_memory
    end

    ## VM hostname
    worker.vm.box = $box
    worker.vm.hostname = "k8Worker2"

    ## Network config
    worker.vm.network :private_network, ip: WORKER2_IP

    ## provision
    worker_transfer_certs(worker, 2)
    worker_transfer_kubeconfig_files(worker, 2)
    # worker.vm.provision :file, :source => "auth_generated/kube-proxy.kubeconfig", :destination => "kube-proxy.kubeconfig"
    # worker.vm.provision :file, :source => "certs_generated/worker2.pem", :destination => "worker2.pem"
    # worker.vm.provision :file, :source => "certs_generated/worker2-key.pem", :destination => "worker2-key.pem"

    worker.vm.provision :shell, inline: "sudo mkdir -p /opt/cni"
    worker.vm.provision :shell, inline: "sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}"
    worker.vm.provision :shell, inline: "sudo mv ca.pem /var/lib/kubernetes/"
    worker.vm.provision :shell, inline: "sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig"
    worker.vm.provision :shell, inline: "sudo mv kube-proxy.pem kube-proxy-key.pem /var/lib/kubernetes/"
    worker.vm.provision :shell, inline: "sudo mv worker2.pem /var/lib/kubelet"
    worker.vm.provision :shell, inline: "sudo mv worker2-key.pem /var/lib/kubelet"
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [WORKER2_NAME]

  end

  config.vm.define "worker3" do |worker|
    worker.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "k8Worker3"
      vb.cpus = $worker_cpus
      vb.memory = $worker_vm_memory
    end

    ## VM hostname
    worker.vm.box = $box
    worker.vm.hostname = "k8Worker3"

    ## Network config
    worker.vm.network :private_network, ip: WORKER3_IP

    ## provision
    worker_transfer_certs(worker, 3)
    worker_transfer_kubeconfig_files(worker, 3)
    # worker.vm.provision :file, :source => "auth_generated/kube-proxy.kubeconfig", :destination => "kube-proxy.kubeconfig"
    # worker.vm.provision :file, :source => "auth_generated/worker3.kubeconfig", :destination => "worker3.kubeconfig"
    # worker.vm.provision :file, :source => "certs_generated/worker3.pem", :destination => "worker3.pem"
    # worker.vm.provision :file, :source => "certs_generated/worker3-key.pem", :destination => "worker3-key.pem"

    worker.vm.provision :shell, inline: "sudo mkdir -p /opt/cni"
    worker.vm.provision :shell, inline: "sudo mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}"
    worker.vm.provision :shell, inline: "sudo mv ca.pem /var/lib/kubernetes/"
    worker.vm.provision :shell, inline: "sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig"
    worker.vm.provision :shell, inline: "sudo mv kube-proxy.pem kube-proxy-key.pem /var/lib/kubernetes/"
    worker.vm.provision :shell, inline: "sudo mv worker3.pem /var/lib/kubelet"
    worker.vm.provision :shell, inline: "sudo mv worker3-key.pem /var/lib/kubelet"
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [WORKER3_NAME]

  end

end
