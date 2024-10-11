#!/bin/bash

_vbox_mng="VBoxManage.exe"

#> vm_list
function vm_list {
    "$_vbox_mng" list vms
}

#> vm_state {vm_id}
function vm_state {
    "$_vbox_mng" showvminfo "$1" | grep State
}

#> vm_poweroff {vm_id}
function vm_poweroff {
    "$_vbox_mng" controlvm "$1" poweroff
}

#> vm_destroy {vm_id}
function vm_destroy {
    vm_poweroff "$1"
    "$_vbox_mng" unregistervm "$1"
}

function vm_network_create {
    "$_vbox_mng" hostonlyif create
}

# Show commands when no argument provided
if [[ "$#" -eq 0 ]]; then
    echo "-- commands --"
    echo ""
    cat "$(pwd)/$(dirname "$0")/$(basename "$0")" | grep -E "^#>"
    exit 0
fi

# Execute with parameters
"$@"