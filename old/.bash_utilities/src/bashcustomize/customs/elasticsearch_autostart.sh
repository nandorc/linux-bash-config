#!/bin/bash

source ~/.bash_utilities/lib/messages.sh
source ~/.bash_utilities/src/bashcustomize/lib/elasticsearch.sh

mustSkip=0
isRunning=0
triesCount=0
printInfoMessage "Checking elasticsearch service..."
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
  printInfoMessage "Elasticsearch service is stopped."
  startElasticsearchService
else
  printInfoMessage "Elasticsearch service is running."
fi
unset triesCount mustSkip isRunning
