VAGRANT_IMAGE_NAME = "ubuntu/focal64"

Vagrant.configure("2") do |config|
    config.vm.box = VAGRANT_IMAGE_NAME
    config.vm.box_check_update = false
    config.ssh.insert_key = false

    # Provision OpenVPN
    config.vm.define "openvpn" do |openvpn|
        openvpn.vm.provider "virtualbox" do |vb|
            vb.name = "openvpn"
            vb.memory = 512
            vb.cpus = 1
        end
        openvpn.vm.hostname = "openvpn"
        openvpn.vm.network :private_network, ip: "10.10.10.10"
        openvpn.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbooks/openvpn.yml"
            ansible.extra_vars = {
                node_ip: "10.10.10.10",
            }
        end
    end
end
