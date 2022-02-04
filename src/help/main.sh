#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh

if [ -z "$1" ]; then
    basher mdv ~/.basher/src/help/README.md
elif [ "$1" = "list" ]; then
    ~/.basher/src/help/cmd/list.sh
elif [ ! -d ~/.basher/src/"$1" ]; then
    printErrorMessage "'$1' is not a valid command or component" before
    printMessage "To get a list of available commands and components type: basher help:list" after
fi
