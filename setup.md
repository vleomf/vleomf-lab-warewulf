```bash
#!/bin/bash
#
# Load environment
#
source .env

#
# Validate required commands exist in PATH
# https://developer.hashicorp.com/vagrant/downloads
#
function shell_cmdexist {
    if ! command -v  "$1" >> /dev/null; then
        echo "$1 not found"
        exit -1
    fi
}

shell_cmdexist "$_vbox_manage"
shell_cmdexist "vagrant" # Version (2.4.1

#
# Validate Virtualbox Supported version
# https://developer.hashicorp.com/vagrant/docs/providers/virtualbox
# Note: Vargant does not support latest virtualbox (7.1)
#       I will validate for latest supported
#
if !(echo "check vbox version: $($_vbox_manage --version)" | grep -E '^check vbox version: 7.0.*'); then
    echo "vbox version must be 7.0.x"
    exit -1
fi


#
# Install required plugins
#
# vagrant plugin install vagrant-reload

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-bindfs
vagrant plugin install virtualbox_WSL2
vagrant plugin install vagrant-vbguest
```




Some configurations to review later... using vbhost mounts
```ruby
# Problems with almalinux/9 (Don't forget to restart vboxadd-service.service)
#   VirtualBox Guest Additions: Starting.
#   VirtualBox Guest Additions: Setting up modules
#   VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
#   modules.  This may take a while.
#   VirtualBox Guest Additions: To build modules for other installed kernels, run
#   VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
#   VirtualBox Guest Additions: or
#   VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup all
#   VirtualBox Guest Additions: Kernel headers not found for target kernel 
#   5.14.0-427.28.1.el9_4.x86_64. Please install them and execute
#     /sbin/rcvboxadd setup

config.vm.synced_folder './src/warewulf_lab', '/home/vagrant/', type: "rsync" #disabled: true
config.vm.define "warewulf_lab" do |x|
    x.vm.box = "almalinux/9"
    x.vm.box_version = "9.4.20240805"
    # x.vm.hostname = "warewulf_lab"
    x.vm.provision "shell", inline: "whoami; pwd"
end
```