#!/bin/bash

_vbox_cmd="VBoxManage.exe"

function vm_list {
    "$_vbox_cmd" list vms
}

# params: {vm_id}
function vm_state {
    "$_vbox_cmd" showvminfo "$1" | grep State
}

# params: {vm_id}
function vm_poweroff {
    "$_vbox_cmd" controlvm "$1" poweroff
}

# params: {vm_id}
function vm_delete {
    vm_poweroff "$1"
    "$_vbox_cmd" unregistervm "$1"
}

# Execute with parameters
"$@"