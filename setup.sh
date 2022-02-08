#!/bin/bash

# Check and load dependencies
if [ ! -d ~/.basher/lib ]; then
    echo -e "\nUnexpected error while trying to setup\n" && exit 1
fi
source ~/.basher/lib/messages.sh

# Init message
printInfoMessage "Starting Bash Utilities setup..." both

# Validate existence of ~/.basher/etc/config.sh file
if [ ! -f ~/.basher/etc/config.sh ]; then
    printErrorMessage "Setup failed! Can't find config file." after && exit 1
fi

# Create ~/.bash_aliases if not exists
if [ ! -f ~/.bash_aliases ]; then
    printWarningMessage "No ~/.bash_aliases file found. One will be created."
    touch ~/.bash_aliases
fi

# Include config loading at ~/.bash_aliases if is not present.
if [ -z "$(cat ~/.bash_aliases | grep '[ -f ~/.basher/etc/config.sh ] && . ~/.basher/etc/config.sh')" ]; then
    printMessage "Adding config loading at ~/.bash_aliases"
    echo '[ -f ~/.basher/etc/config.sh ] && . ~/.basher/etc/config.sh' >>~/.bash_aliases
else
    printWarningMessage "Bash Utilities is currently setted to work on this machine."
fi

# End message
printInfoMessage "Bash Utilities setup finished." before
printMessage "You must restart to apply changes and start using Bash Utilities." after
