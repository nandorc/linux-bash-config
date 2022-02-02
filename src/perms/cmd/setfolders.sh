#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Set variables
path=$1
dirperm=$2

# Assign permissions
if [ ! -z "$dirperm" ]; then
    printInfoMessage "Setting $dirperm permission to folders at '$path'" before
    sudo find "$path" -type d ! -perm "$dirperm" -exec chmod -c "$dirperm" {} +
fi

# Unset variables
unset path dirperm
