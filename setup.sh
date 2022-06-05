#!/bin/bash

# Check and load dependencies
[ ! -d ~/.basher/lib ] && echo -e "\nUnexpected error while trying to setup Basher for Linux tool\n" && exit 1
source ~/.basher/lib/messagehandler.sh

# Init message
commandBlockHeading "BASHER FOR LINUX SETUP" 1 0

# Validate existence of ~/.basher/etc/loader.sh file
[ ! -f ~/.basher/etc/loader.sh ] && genericException "Can't find loader file" 0 1 

# Create ~/.bash_aliases if not exists
if [ ! -f ~/.bash_aliases ]; then
    genericWarnMessage "No $(color yellow)~/.bash_aliases$(color) file found" 0 0
    touch ~/.bash_aliases
    genericInfoMessage "New $(color yellow)~/.bash_aliases$(color) created" 0 0
fi

# Include config loading at ~/.bash_aliases if is not present.
if [ -z "$(cat ~/.bash_aliases | grep '[ -f ~/.basher/etc/loader.sh ] && . ~/.basher/etc/loader.sh')" ]; then
    echo '[ -f ~/.basher/etc/loader.sh ] && . ~/.basher/etc/loader.sh' >>~/.bash_aliases
    genericInfoMessage "Configuration loading instruction added at $(color yellow)~/.bash_aliases$(color)" 0 0
    genericInfoMessage "Basher for Linux setted correctly" 0 0
    genericInfoMessage "You must restart to apply changes or you can execute $(color yellow)source ~/.basher/etc/loader.sh$(color) to start using Basher for Linux" 0 1
else
    genericInfoMessage "Basher for Linux is currently setted to work on this machine" 0 1
fi
