#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh
source ~/.basher/lib/inihandler.sh

# Begin
options=$(getRebuildedOptions $*)
printColoredMessage "Enabling features..." --wrap-position begin $options

# Check features.ini file
if [ ! -f ~/.basher/src/boot/etc/features.ini ]; then
    printWarningMessage "* features.ini not set"
    basher boot:reset --no-color --spacing none --no-restart
fi

# Enable services
params=$(getOptionsPrunedParams $*)
if [ -z "$params" ]; then
    commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
    commandsArray=(${commands// / })
    homeDir=~/.basher/src/
    for i in "${commandsArray[@]}"; do
        if [ -f "$i"/etc/loader.sh ]; then
            command=$(echo $i | sed -e "s|$homeDir||g")
            setINIVar ~/.basher/src/boot/etc/features.ini $command on
            printMessage "* $command was setted to load on boot."
            unset command
        fi
    done
    unset commands commandsArray homeDir i
else
    paramsArray=(${params// / })
    for i in "${paramsArray[@]}"; do
        if [ -f ~/.basher/src/"$i"/etc/loader.sh ]; then
            setINIVar ~/.basher/src/boot/etc/features.ini $i on
            printMessage "* $i was setted to load on boot."
        else
            printWarningMessage "* $i can't be setted to load on boot."
        fi
    done
    unset paramsArray i
fi
unset params

# End
printColoredMessage "Features enabling process finished" --spacing none $(pruneFlagValue --spacing $options)
printColoredMessage "You must restart your system to apply changes." --wrap-position end --type warning $(pruneFlag --no-color $options)
unset options
