#!/bin/bash

# Check and load dependencies
[ ! -d ~/.basher/lib ] && echo -e "\nUnexpected error while trying to setup Basher for Linux tool\n" && exit 1
source ~/.basher/lib/colorhandler.sh

# Init message
echo -e "\n$(color green)START:$(color none) Basher for Linux setup"

# Validate existence of ~/.basher/etc/loader.sh file
[ ! -f ~/.basher/etc/loader.sh ] && echo -e "$(color red)FAIL:$(color none) Can't find loader file\n" && exit 1

# Create ~/.bash_aliases if not exists
if [ ! -f ~/.bash_aliases ]; then
    echo -e "$(color yellow)WARNING:$(color none) No $(color yellow)~/.bash_aliases$(color none) file found"
    touch ~/.bash_aliases
    echo -e "$(color blue)INFO:$(color none) New $(color yellow)~/.bash_aliases$(color none) created"
fi

# Include config loading at ~/.bash_aliases if is not present.
if [ -z "$(cat ~/.bash_aliases | grep '[ -f ~/.basher/etc/loader.sh ] && . ~/.basher/etc/loader.sh')" ]; then
    echo '[ -f ~/.basher/etc/loader.sh ] && . ~/.basher/etc/loader.sh' >>~/.bash_aliases
    echo -e "$(color blue)INFO:$(color none) Configuration loading instruction added at $(color yellow)~/.bash_aliases$(color none)"
    echo -e "$(color green)FINISH:$(color none) Basher for Linux setted correctly"
    echo -e "$(color blue)INFO:$(color none) You must restart to apply changes or you can execute $(color yellow)source ~/.basher/etc/loader.sh$(color none) to start using Basher for Linux\n"
else
    echo -e "$(color green)FINISH:$(color none) Basher for Linux is currently setted to work on this machine\n"
fi
