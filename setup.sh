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