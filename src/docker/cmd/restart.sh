#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

serviceName="docker"
options=$(getRebuildedOptions $*)
printColoredMessage "<DockerServiceRestart>" --wrap-position begin $options
if [ $(basher $serviceName:status --output bool) -eq 1 ]; then
    basher $serviceName:stop --no-color --spacing none && basher $serviceName:start --no-color --spacing none
else
    basher $serviceName:start --no-color --spacing none
fi
printColoredMessage "</DockerServiceRestart>" --wrap-position end $options
unset serviceName options
