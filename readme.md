# WSL2 Setup

Include in .bashrc, personally I like to configure my system
with a .bash_profile
```bash
#
# Add this in .bashrc file when you find convenient
#
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

#
# export required environmental variables
#
viceo@viceo-rog:~/Projects/vleomf-lab-warewulf$ cat ~/.bash_profile
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/viceo"
#export VAGRANT_DEFAULT_PROVIDER=hyperv
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
```


Install Ansible (not working... movin on virtualenvs)
```bash
sudo apt install pipx -y
pipx install --include-deps ansible
```


install Ansible (virtualenv)
```bash
sudo apt install virtualenv
virtualenv env
source  env/bin/activate
pip install ansible

```

More commands
```bash
# Start project
vagrant up

# Status project
vagrant status

# SSH access to VM
vagrant ssh

# Watch for changes
vagrant rsync-auto

# Provision ansible playbook
vagrant provision

# Reload without provisioning (ansible)
# This will apply changes in vagrantfile
vagrant reload

# Restart and reprovision
vagrant reload --provision

# Destroy environment
vagrant destroy -f
```

---
## Notes on setup

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

# Useful for scp from or to vms
vagrant plugin install vagrant-scp
#   vagrant scp warewulf_lab:/etc/warewulf src/warewulf_lab/
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