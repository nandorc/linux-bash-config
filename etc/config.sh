#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Init message
printInfoMessage "Loading Basher for Linux..."

# Include Bash Utilities bin folder to path
PATH="$PATH:~/.basher/bin"
printMessage " * basher command included on PATH"

# Load basher configurations
. ~/.basher/src/config/etc/loader.sh

# Launch basher boot services initialization
if [ -f ~/.basher/src/boot/var/features.ini ] && [ -n "$(cat ~/.basher/src/boot/var/features.ini)" ]; then
    printMessage "Type user password in order to start services loading or press Ctrl+C to ommit it."
    sudo echo "<ServicesInitialization>" && ~/.basher/src/boot/etc/init.sh && echo "</ServicesInitialization>"
fi

# Finish and print post init warning
printInfoMessage "Basher for Linux loaded"
# sleep 1 && clear

# # Print post-loading message if exists
# if [ ! -z "$post_load_message" ]; then
#     printWarningMessage "$post_load_message" both
# fi
# unset post_load_message
