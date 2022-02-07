#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="apache"
options=$(getRebuildedOptions $*)
printColoredMessage "Stoping $serviceName service..." --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 0 ]; then
    printMessage "* $serviceName service is currently stopped"
else
    # Begin service starting process
    sudo service apache2 stop
    # End service starting process
fi
printColoredMessage "stopping process finished" --wrap-position end $options
unset serviceName options
