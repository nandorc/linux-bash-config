#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="mysql"
options=$(getRebuildedOptions $*)
printColoredMessage "Stoping $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 0 ]; then
    printColoredMessage " * $serviceName service is currently stopped" --wrap-position end --no-color $options
else
    sudo service mysql stop
    printColoredMessage " * $serviceName service stoped" --wrap-position end --no-color $options
fi
unset serviceName options
