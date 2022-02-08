#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="mysql"
options=$(getRebuildedOptions $*)
printColoredMessage "Starting $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 1 ]; then
    printColoredMessage " * $serviceName service is currently running" --wrap-position end --no-color $options
else
    sudo service mysql start
    printColoredMessage " * $serviceName service started" --wrap-position end --no-color $options
fi
unset serviceName options
