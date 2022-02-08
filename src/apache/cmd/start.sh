#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

# Format command options
options=$(getRebuildedOptions $*)

# Begining message
printColoredMessage "Starting apache service..." --wrap-position begin $options

# Check and start service
if [ $(basher apache:status --output bool) -eq 1 ]; then
    printColoredMessage " * apache service is currently running" --wrap-position end --no-color $options
else
    sudo service apache2 start
    printColoredMessage " * apache service started" --wrap-position end --no-color $options
fi

# Clean variables
unset options
