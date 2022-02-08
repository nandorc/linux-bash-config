#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

output=$(getFlagValue --output $*)
if [ $(hasFlag --output $*) -eq 1 ] && [ -n "$output" ] && [ "$output" != "string" ] && [ "$output" != "response" ] && [ "$output" != "bool" ]; then
    printErrorMessage "No valid --output value received" both
else
    options=$(getRebuildedOptions $*)
    [ -z "$output" ] && output="string"
    if [ "$output" = "string" ]; then
        printColoredMessage "Checking elasticsearch service status..." --wrap-position begin $options
    elif [ "$output" = "response" ]; then
        printColoredMessage "Trying to get response from elasticsearch service..." --wrap-position begin $options
    fi
    triesCount=0 && canContinue=0
    while [ $canContinue -eq 0 ] && [ $triesCount -lt 5 ]; do
        rm -f ~/.basher/src/elasticsearch/var/http_response
        triesCount=$(($triesCount + 1)) && sleep 2
        http_response_code=$(curl -s -w '%{http_code}' -o ~/.basher/src/elasticsearch/var/http_response -X GET 'http://localhost:9200/_cat/health?v&pretty')
        [ "$http_response_code" != "000" ] && canContinue=1
    done
    unset triesCount canContinue && boolResult=0
    [ "$http_response_code" = "200" ] && boolResult=1
    if [ "$output" = "bool" ]; then
        echo $boolResult
    else
        stringResult="elasticsearch service is"
        if [ "$http_response_code" = "200" ]; then
            stringResult="$stringResult running"
        elif [ "$http_response_code" = "000" ]; then
            stringResult="$stringResult not running"
        else
            stringResult="$stringResult not reachable"
        fi
        if [ "$output" = "string" ]; then
            printMessage "* $stringResult"
        elif [ -f ~/.basher/src/elasticsearch/var/http_response ]; then
            cat ~/.basher/src/elasticsearch/var/http_response
        else
            printMessage "* elasticsearch service has no response. $stringResult"
        fi
        printColoredMessage "operation completed" --wrap-position end $options
        unset stringResult
    fi
    unset options http_response_code boolResult
fi
unset output
