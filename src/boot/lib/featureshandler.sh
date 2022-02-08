#!/bin/bash

# Check if the given command is a feature
# $1 command name
function isFeature() {
    basePath=~/.basher/src/"$1"
    if [ -f "$basePath"/etc/feature-conf.ini ] && [ -f "$basePath"/cmd/start.sh ] && [ -f "$basePath"/cmd/stop.sh ] && [ -f "$basePath"/cmd/restart.sh ] && [ "$basePath"/cmd/status.sh ]; then
        echo 1
    else
        echo 0
    fi
    unset basePath
}
