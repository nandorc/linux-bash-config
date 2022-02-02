#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh

if [ "$1" = "--help" ]; then
    basher mdv ~/.basher/src/boot/README.md
else
    printErrorMessage "No valid options received." before
    printWarningMessage "Type 'basher boot --help' to see available options." after
fi
