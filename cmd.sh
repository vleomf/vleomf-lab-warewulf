#!/bin/bash
#
# Source Environment
#
source .env
source "src/functions.sh"

#
# Help menu appear when no parameter is set
#
if [[ -z "$1" ]]; then
    echo "Available Functions"
    echo " vm_list               | List all virtual machines"
    echo " vm_state {vbox name}  | Show vm status"
    exit 0
fi

#
# Execute your function name with parameters
#
"$@"