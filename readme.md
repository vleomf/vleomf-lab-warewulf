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