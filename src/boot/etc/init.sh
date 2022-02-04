#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/src/boot/lib/featureshandler.sh

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
    if [ $(isFeature $command) -eq 1 ] && [ "$(getINIVar ~/.basher/src/boot/etc/features.ini $command)" = "on" ]; then
        printMessage "Checking $command service status..."
        if [ $(basher $command:status --output bool) -eq 1 ]; then
            printMessage "$command service running"
        else
            printMessage "$command service not running"
            basher $command:start --no-color --spacing none
        fi
    fi
done
unset commands commandsArray homeDir i command

# END
printMessage "Services initialized"
