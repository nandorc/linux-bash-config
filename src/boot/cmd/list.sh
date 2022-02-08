#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
current_values=""
printColoredMessage "Getting currently defined values at features.ini file..." --wrap-position begin $options
[ -f ~/.basher/src/boot/var/features.ini ] && current_values=$(cat ~/.basher/src/boot/var/features.ini)
if [ -z "$current_values" ]; then
    printColoredMessage "No values defined" --wrap-position end --type warning $(pruneFlag --no-color $options)
else
    printColoredMessage "$current_values" --wrap-position end --no-color $options
fi
unset options current_values
