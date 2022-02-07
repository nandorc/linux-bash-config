#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="apache"
options=$(getRebuildedOptions $*)
printColoredMessage "Starting $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 1 ]; then
    printMessage "* $serviceName service is currently running"
else
    # Begin service starting process
    sudo service apache2 start
    # End service starting process
fi
printColoredMessage "starting process finished" --wrap-position end $options
unset serviceName options
