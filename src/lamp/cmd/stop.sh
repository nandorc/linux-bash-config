#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<LAMPServicesStop>" --wrap-position begin $options
# Begin service starting process
basher apache:stop --no-color --spacing none
basher mysql:stop --no-color --spacing none
# End service starting process
printColoredMessage "</LAMPServicesStop>" --wrap-position end $options
unset options
