#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Init message
printInfoMessage "Loading Basher for Linux..."

# Pre loading warnings cleaning
find ~/.basher/src/* -type f -name warning -exec rm -f {} +
printMessage " * previos generated warnings cleaned"

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
printInfoMessage "Basher for Linux loaded" && sleep 1 && clear

# Post loading warning messages display
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commandsArray=(${commands// / })
homeDir=~/.basher/src/
for i in "${commandsArray[@]}"; do
    if [ -f "$i"/var/warning ] && [ -n "$(cat "$i"/var/warning)" ]; then
        command=$(echo $i | sed -e "s|$homeDir||g")
        printWarningMessage "[$command warnings]"
        printWarningMessage "$(cat "$i"/var/warning)" after
        unset command
    fi
done
unset commands commandsArray homeDir i
