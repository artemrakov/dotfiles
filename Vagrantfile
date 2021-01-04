# For test purposes only
Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |v|
    v.memory = 4096
  end

  config.vm.define "appserver" do |app|
    app.vm.box = "ubuntu/bionic64"
    app.vm.hostname = "appserver"
    app.vm.network :private_network, ip: "10.10.10.20"

    app.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/main.yml"
      ansible.groups = {
        "app" => ["appserver"],
      }
    end
  end
end
