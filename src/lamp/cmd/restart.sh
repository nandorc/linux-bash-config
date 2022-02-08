#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<LAMPServicesRestart>" --wrap-position begin $options
# Restart related services
basher apache:restart --no-color --spacing none
basher mysql:restart --no-color --spacing none
# End message
printColoredMessage "</LAMPServicesRestart>" --wrap-position end $options
unset options
