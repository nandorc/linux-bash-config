#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

output=$(getFlagValue --output $*)
if [ $(hasFlag --output $*) -eq 1 ] && [ -n "$output" ] && [ "$output" != "string" ] && [ "$output" != "bool" ]; then
    printErrorMessage "No valid --output value received" both
else
    [ -z "$output" ] && output="string"
    # Begin boolean service validation
    boolResult=1
    [ -n "$(sudo service jenkins status 2>/dev/null | grep "is not running")" ] && boolResult=0
    if [ "$output" = "bool" ]; then
        echo $boolResult
    else
        # Begin string result
        serviceName="jenkins"
        options=$(getRebuildedOptions $*)
        printColoredMessage "Checking $serviceName service status..." --wrap-position begin $options
        stringResult=" * $serviceName service is not running"
        [ $boolResult -eq 1 ] && stringResult=" * $serviceName is running"
        printColoredMessage "$stringResult" --wrap-position end --no-color $options
        unset serviceName options stringResult
    fi
    unset boolResult
fi
unset output
