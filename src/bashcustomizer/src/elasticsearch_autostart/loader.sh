#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/commands.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# Check service loading
mustSkip=0 && isRunning=0 && triesCount=0
printMessage "Checking elasticsearch service..."
while [ $mustSkip -eq 0 ]; do
    triesCount=$(($triesCount + 1))
    isRunning=$(checkElasticSearchService)
    if [ $isRunning -eq 1 ] || [ $triesCount -eq 5 ]; then
        mustSkip=1
    else
        sleep 5
    fi
done
if [ $isRunning -eq 0 ]; then
    wrapCommand 'Starting elasticsearch service...' 'startElasticsearchService'
else
    printMessage "done"
fi
unset triesCount mustSkip isRunning
