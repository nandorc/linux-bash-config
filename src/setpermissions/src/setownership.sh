#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# Assign ownership
if [ ! -z "$ownername" ]; then
    if [ ! -z "$groupname" ]; then
        printInfoMessage "SETTING $ownername as OWNER AND $groupname AS GROUP FOR $path" before
    else
        printInfoMessage "SETTING OWNERSHIP TO $ownername FOR $path" before
        groupname="$ownername"
    fi
    sudo chown -R -c "$ownername":"$groupname" "$path"
elif [ ! -z "$groupname" ]; then
    printInfoMessage "SETTING $groupname AS GROUP FOR $path" before
    sudo chown -R -c :"$groupname" "$path"
fi
