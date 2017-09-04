
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

WORKER1_IP= "192.68.50.101"
WORKER2_IP= "192.68.50.102"
WORKER3_IP= "192.68.50.103"

KUBERNETES_PUBLIC_ADDRESS = "192.68.50.10"


## Variables
$box = "ubuntu/xenial64"
$controller_cpus = 1
$controller_vm_memory = 1024

$worker_count = 3
$worker_cpus = 2
$worker_vm_memory = 2048

##########################################
### Functions

def controller_transfer_certs(controller)
  controller.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  controller.vm.provision :file, :source => "certs_generated/ca-key.pem", :destination => "ca-key.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes.pem", :destination => "kubernetes.pem"
  controller.vm.provision :file, :source => "certs_generated/kubernetes-key.pem", :destination => "kubernetes-key.pem"
  controller.vm.provision :file, :source => "authentication/token.csv", :destination => "token.csv"
  controller.vm.provision :file, :source => "authentication/authentication-policy.jsonl", :destination => "authentication-policy.jsonl"
end

def worker_transfer_certs(worker)
  worker.vm.provision :file, :source => "certs_generated/ca.pem", :destination => "ca.pem"
  worker.vm.provision :file, :source => "certs_generated/kube-proxy.pem", :destination => "kube-proxy.pem"
  worker.vm.provision :file, :source => "certs_generated/kube-proxy-key.pem", :destination => "kube-proxy-key.pem"
end

def worker_transfer_kubeconfig_files(worker)
  worker.vm.provision :file, :source => "auth_generated/bootstrap.kubeconfig", :destination => "bootstrap.kubeconfig"
  worker.vm.provision :file, :source => "auth_generated/kube-proxy.kubeconfig", :destination => "kube-proxy.kubeconfig"
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
    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER1_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh",
                 :args => CONTROLLER1_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh",
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
    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER2_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh",
                 :args => CONTROLLER2_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh",
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
    controller.vm.provision :shell, :path => "controller_setup_scripts/controller-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-setup.sh"
    controller.vm.provision :shell, :path => "controller_setup_scripts/etcd-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/etcd-svc-install.sh",
                 :args => [ETCD1_NAME,CONTROLLER1_IP,ETCD1_IP,ETCD2_IP,ETCD3_IP]

    controller.vm.provision :shell, :path => "controller_setup_scripts/control-plane-bin-install.sh"

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/apiserver-svc-install.sh",
                 :args => [CONTROLLER3_IP,CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/controller-svc-install.sh",
                 :args => CONTROLLER3_IP

    controller.vm.provision :shell,
                 :path => "controller_setup_scripts/scheduler-svc-install.sh",
                 :args => CONTROLLER3_IP

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
    worker_transfer_certs(worker)
    worker_transfer_kubeconfig_files(worker)
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-setup.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

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
    worker_transfer_certs(worker)
    worker_transfer_kubeconfig_files(worker)
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-setup.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

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
    worker_transfer_certs(worker)
    worker_transfer_kubeconfig_files(worker)
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-setup.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/worker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-bin-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/docker-svc-install.sh"
    worker.vm.provision :shell, :path => "worker_setup_scripts/kubeproxy-svc-install.sh"
    worker.vm.provision :shell,
                        :path => "worker_setup_scripts/kubelet-svc-install.sh",
                        :args => [CONTROLLER1_IP,CONTROLLER2_IP,CONTROLLER3_IP]

  end

end
