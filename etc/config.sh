#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Init message
printInfoMessage "Loading Bash Utilities system..."

# Include Bash Utilities bin folder to path
PATH="$PATH:~/.basher/bin"

# Load bashcustomizer configuration
. ~/.basher/src/bashcustomizer/etc/config.sh

# Finish and print post init warning
printInfoMessage "Bash Utilities system loaded."
sleep 1 && clear

# Print post-loading message if exists
if [ ! -z "$post_load_message" ]; then
    printWarningMessage "$post_load_message" both
fi
unset post_load_message
