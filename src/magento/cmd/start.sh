#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="magento"
options=$(getRebuildedOptions $*)
printColoredMessage "Starting $serviceName services..." --wrap-position begin $options
# Begin service starting process
basher apache:start --no-color --spacing none
basher mysql:start --no-color --spacing none
basher elasticsearch:start --no-color --spacing none
# End service starting process
printColoredMessage "starting process finished" --wrap-position end $options
unset serviceName options
