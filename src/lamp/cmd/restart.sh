#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="lamp"
options=$(getRebuildedOptions $*)
printColoredMessage "Restarting $serviceName services..." --wrap-position begin $options
# Restart related services
basher apache:restart --no-color --spacing none
basher mysql:restart --no-color --spacing none
# End message
printColoredMessage "restarting process finished" --wrap-position end $options
unset serviceName options
