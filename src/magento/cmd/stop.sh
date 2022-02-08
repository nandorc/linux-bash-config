#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<MagentoServicesStop>" --wrap-position begin $options
# Begin service starting process
basher apache:stop --no-color --spacing none
basher mysql:stop --no-color --spacing none
basher elasticsearch:stop --no-color --spacing none
# End service starting process
printColoredMessage "</MagentoServicesStop>" --wrap-position end $options
unset options
