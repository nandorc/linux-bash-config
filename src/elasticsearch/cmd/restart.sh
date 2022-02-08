#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "<ElasticsearchServiceRestart>" --wrap-position begin $options
if [ $(basher elasticsearch:status --output bool) -eq 1 ]; then
    basher elasticsearch:stop --no-color --spacing none && [ -z "$(cat ~/.basher/src/elasticsearch/var/warning)" ] && basher elasticsearch:start --no-color --spacing none
else
    basher elasticsearch:start --no-color --spacing none
fi
printColoredMessage "</ElasticsearchServiceRestart>" --wrap-position end $options
unset serviceName options
