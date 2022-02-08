#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/src/boot/lib/featureshandler.sh

# Begin
options=$(getRebuildedOptions $*)
printColoredMessage "Enabling features..." --wrap-position begin $options

# Check features.ini file
if [ ! -f ~/.basher/src/boot/etc/features.ini ]; then
    printWarningMessage " * features.ini not set"
    basher boot:reset --no-color --spacing none --no-restart
fi

# Enable services
params=$(getOptionsPrunedParams $*)
if [ -z "$params" ]; then
    commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
    commandsArray=(${commands// / })
    homeDir=~/.basher/src/
    for i in "${commandsArray[@]}"; do
        command=$(echo $i | sed -e "s|$homeDir||g")
        if [ $(isFeature $command) -eq 1 ]; then
            setINIVar ~/.basher/src/boot/etc/features.ini $command on
            printMessage " * $command was enabled to load on boot"
        fi
    done
    unset commands commandsArray homeDir i command
else
    paramsArray=(${params// / })
    for i in "${paramsArray[@]}"; do
        if [ $(isFeature $i) -eq 1 ]; then
            setINIVar ~/.basher/src/boot/etc/features.ini $i on
            printMessage " * $i was enabled to load on boot"
        else
            printWarningMessage " * $i is not a service name"
        fi
    done
    unset paramsArray i
fi
unset params

# End
printColoredMessage "You must restart your system to apply changes" --wrap-position end --type warning $(pruneFlag --no-color $options)
unset options
