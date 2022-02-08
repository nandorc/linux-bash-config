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
    if [ $(basher apache:status --output bool) -eq 0 ] || [ $(basher mysql:status --output bool) -eq 0 ] || [ $(basher elasticsearch:status --output bool) -eq 0 ]; then
        boolResult=0
    fi
    # End boolean service validation
    if [ "$output" = "bool" ]; then
        echo $boolResult
    else
        # Begin string result
        serviceName="magento"
        options=$(getRebuildedOptions $*)
        printColoredMessage "Checking $serviceName services status..." --wrap-position begin $options
        stringResult=" * At least one $serviceName service is not running"
        [ $boolResult -eq 1 ] && stringResult=" * All $serviceName services are running"
        printColoredMessage "$stringResult" --wrap-position end --no-color $options
        unset serviceName options stringResult
    fi
    unset boolResult
fi
unset output
