#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Set variables
path=$1
ownername=$2
groupname=$3

# Assign ownership
if [ ! -z "$ownername" ]; then
    if [ ! -z "$groupname" ]; then
        printInfoMessage "Setting '$ownername' as owner and '$groupname' as group for '$path'" before
    else
        printInfoMessage "Setting ownership to '$ownername' for '$path'" before
        groupname="$ownername"
    fi
    sudo chown -R -c "$ownername":"$groupname" "$path"
elif [ ! -z "$groupname" ]; then
    printInfoMessage "Setting '$groupname' as group for '$path'" before
    sudo chown -R -c :"$groupname" "$path"
fi

# Unset variables
unset path ownername groupname
