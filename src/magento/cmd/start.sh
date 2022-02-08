#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<MagentoServicesStart>" --wrap-position begin $options
# Begin service starting process
basher apache:start --no-color --spacing none
basher mysql:start --no-color --spacing none
basher elasticsearch:start --no-color --spacing none
# End service starting process
printColoredMessage "</MagentoServicesStart>" --wrap-position end $options
unset options
