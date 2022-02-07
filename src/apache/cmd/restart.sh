#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="apache"
options=$(getRebuildedOptions $*)
printColoredMessage "Restarting $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 1 ]; then
    basher $serviceName:stop --no-color --spacing none && basher $serviceName:start --no-color --spacing none
else
    basher $serviceName:start --no-color --spacing none
fi
printColoredMessage "restarting process finished" --wrap-position end $options
unset serviceName options
