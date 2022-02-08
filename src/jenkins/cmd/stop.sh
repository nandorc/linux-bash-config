#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="jenkins"
options=$(getRebuildedOptions $*)
printColoredMessage "Stoping $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 0 ]; then
    printMessage " * $serviceName service is currently stopped" --wrap-position end --no-color $options
else
    sudo service jenkins stop
    printColoredMessage " * $serviceName service stopped" --wrap-position end --no-color $options
fi
unset serviceName options
