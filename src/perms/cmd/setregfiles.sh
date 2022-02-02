#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Set variables
path=$1
filperm=$2

# Assign permissions
if [ ! -z "$filperm" ]; then
    printInfoMessage "Setting $filperm permission to files at '$path'" before
    sudo find "$path" -type f ! -perm "-u=x" ! -perm "$filperm" -exec chmod -c "$filperm" {} +
fi

# Unset variables
unset path filperm
