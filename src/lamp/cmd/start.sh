#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<LAMPServicesStart>" --wrap-position begin $options
# Begin service starting process
basher apache:start --no-color --spacing none
basher mysql:start --no-color --spacing none
# End service starting process
printColoredMessage "</LAMPServicesStart>" --wrap-position end $options
unset options
