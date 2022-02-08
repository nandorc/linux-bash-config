#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

# Format command options
options=$(getRebuildedOptions $*)

# Begining message
printColoredMessage "<ApacheServiceRestart>" --wrap-position begin $options

# Check and restart service
if [ $(basher apache:status --output bool) -eq 1 ]; then
    basher apache:stop --no-color --spacing none && basher apache:start --no-color --spacing none
else
    basher apache:start --no-color --spacing none
fi

# Ending message
printColoredMessage "</ApacheServiceRestart>" --wrap-position end $options

# Clean variables
unset options
