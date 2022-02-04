#!/bin/bash

# Check if the given command is a feature
# $1 command name
function isFeature() {
    basePath=~/.basher/src/"$1"/cmd
    if [ -f "$basePath"/start.sh ] && [ -f "$basePath"/stop.sh ] && [ -f "$basePath"/restart.sh ] && [ "$basePath"/status.sh ]; then
        echo 1
    else
        echo 0
    fi
    unset basePath
}
