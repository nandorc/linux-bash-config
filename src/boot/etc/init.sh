#!/bin/bash

# BEGIN
printMessage "Initializing services..."

# Check features.ini file
if [ ! -f ~/.basher/src/boot/etc/features.ini ]; then
    printWarningMessage "* features.ini not set"
    basher boot:reset --no-color --spacing none --no-restart
fi

# Dispatch initializations
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commandsArray=(${commands// / })
homeDir=~/.basher/src/
for i in "${commandsArray[@]}"; do
    command=$(echo $i | sed -e "s|$homeDir||g")
    if [ -f "$i"/etc/loader.sh ] && [ "$(getINIVar ~/.basher/src/boot/etc/features.ini $command)" = "on" ]; then
        . "$i"/etc/loader.sh
    fi
done
unset commands commandsArray homeDir i command

# END
printMessage "Services initialized"
