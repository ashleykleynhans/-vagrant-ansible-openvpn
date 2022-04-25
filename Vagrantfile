VAGRANT_IMAGE_NAME = "ashleykza/jammy64"

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure("2") do |config|
#    if VAGRANT_COMMAND == "ssh"
#        config.ssh.username = "ubuntu"
#    end

    config.vm.box = VAGRANT_IMAGE_NAME
    config.vm.box_check_update = false
    config.ssh.insert_key = false

    config.vm.define "openvpn" do |openvpn|
        openvpn.vm.hostname = "openvpn"
        openvpn.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbooks/openvpn.yml"
        end
#        openvpn.vm.provision "ansible" do |ansible|
#            ansible.playbook = "ansible/playbooks/disable_vagrant_user.yml"
#        end
    end
end
