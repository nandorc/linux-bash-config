#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="lamp"
options=$(getRebuildedOptions $*)
printColoredMessage "Stoping $serviceName services..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 0 ]; then
    printMessage "* $serviceName services are currently stopped"
else
    # Begin service starting process
    basher apache:stop --no-color --spacing none
    basher mysql:stop --no-color --spacing none
    # End service starting process
fi
printColoredMessage "stopping process finished" --wrap-position end $options
unset serviceName options
