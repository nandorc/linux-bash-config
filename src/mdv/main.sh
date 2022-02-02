#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Manage utility parameters
if [ "$1" = "--help" ]; then
    ~/.basher/src/mdv/cmd/display.sh ~/.basher/src/mdv/README.md
elif [ "$1" = "--reset" ]; then
    ~/.basher/src/mdv/cmd/reset.sh
elif [ ! -z "$1" ]; then
    ~/.basher/src/mdv/cmd/display.sh "$1"
else
    printErrorMessage "No valid option provided for mdv." before
    printWarningMessage "Try 'mdv --help' to look for available options." after
fi
