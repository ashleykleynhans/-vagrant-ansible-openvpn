# The official Ubuntu image ubuntu/focal64 has initramfs/initrd issues
# when importing the OVA as am AMI into AWS, geerlingguy/ubuntu2004 image
# does not have any of those issues.
VAGRANT_IMAGE_NAME = "geerlingguy/ubuntu2004"

Vagrant.configure("2") do |config|
    config.vm.box = VAGRANT_IMAGE_NAME
    config.vm.box_check_update = false
    config.ssh.insert_key = false

    config.vm.define "openvpn" do |openvpn|
        openvpn.vm.hostname = "openvpn"
        openvpn.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbooks/openvpn.yml"
        end
    end
end
