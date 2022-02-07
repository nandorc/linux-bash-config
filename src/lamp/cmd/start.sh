#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="lamp"
options=$(getRebuildedOptions $*)
printColoredMessage "Starting $serviceName services..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 1 ]; then
    printMessage "* $serviceName services are currently running"
else
    # Begin service starting process
    basher apache:start --no-color --spacing none
    basher mysql:start --no-color --spacing none
    # End service starting process
fi
printColoredMessage "starting process finished" --wrap-position end $options
unset serviceName options
