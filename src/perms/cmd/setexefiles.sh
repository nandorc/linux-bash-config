#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Set variables
path=$1
exeperm=$2

# Assign permissions
if [ ! -z "$exeperm" ]; then
    printInfoMessage "Setting $exeperm permission to executable files at '$path'" before
    # Files without extension
    sudo find "$path" -type f ! -name "*.*" ! -perm "$exeperm" -exec chmod -c "$exeperm" {} +
    # .sh files
    sudo find "$path" -type f -name "*.sh" ! -perm "$exeperm" -exec chmod -c "$exeperm" {} +
fi

# Unset variables
unset path exeperm
