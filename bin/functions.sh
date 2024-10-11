#!/bin/bash

function vm_list {
    "$_vbox_manage" list vms
}

function vm_state {
    "$_vbox_manage" showvminfo "$1" | grep State
}