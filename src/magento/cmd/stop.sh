#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="magento"
options=$(getRebuildedOptions $*)
printColoredMessage "Stoping $serviceName services..." --wrap-position begin $options
# Begin service starting process
basher apache:stop --no-color --spacing none
basher mysql:stop --no-color --spacing none
basher elasticsearch:stop --no-color --spacing none
# End service starting process
printColoredMessage "stopping process finished" --wrap-position end $options
unset serviceName options
