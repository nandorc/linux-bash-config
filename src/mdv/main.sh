#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/inihandler.sh

# Create config.ini file if is first use
path="$1"
if [ "$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)" = "undefined" ]; then
    printWarningMessage "* basher mdv configuration not defined" before
    ~/.basher/src/mdv/cmd/reset.sh
elif [ "$1" = "--reset" ]; then
    printWarningMessage "* basher mdv configuration will be resetted" before
    path="$2"
    ~/.basher/src/mdv/cmd/reset.sh
fi
if [ -n "$path" ]; then
    ~/.basher/src/mdv/cmd/display.sh "$path"
elif [ "$1" != "--reset" ]; then
    printErrorMessage "A path to a file must be specified" both
    printWarningMessage "Type 'basher help mdv' to know how to use the command" after
fi
