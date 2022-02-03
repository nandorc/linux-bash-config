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
    basher boot:reset --no-color --spacing none
fi

# Enable services
params=$(getOptionsPrunedParams $*)
paramsArray=(${params// / })
for i in "${paramsArray[@]}"; do
    if [ -f ~/.basher/src/"$i"/etc/loader.sh ]; then
        setINIVar ~/.basher/src/boot/etc/features.ini $i on
        printMessage "* $i was setted to load on boot."
    else
        printWarningMessage "* $i can't be setted to load on boot."
    fi
done
unset params paramsArray i

# End
printInfoMessage "Features enabling process finished"
printColoredMessage "You must restart your system to apply changes." --wrap-position end --type warning $options
unset options
