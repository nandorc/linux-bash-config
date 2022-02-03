#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/inihandler.sh

# Init message
printInfoMessage "Loading Basher for Linux..."

# Include Bash Utilities bin folder to path
PATH="$PATH:~/.basher/bin"
printMessage "* basher command included on PATH"

# Launch basher boot services initialization
. ~/.basher/src/boot/etc/init.sh

# Finish and print post init warning
printInfoMessage "Basher for Linux loaded"
# sleep 1 && clear

# # Print post-loading message if exists
# if [ ! -z "$post_load_message" ]; then
#     printWarningMessage "$post_load_message" both
# fi
# unset post_load_message
