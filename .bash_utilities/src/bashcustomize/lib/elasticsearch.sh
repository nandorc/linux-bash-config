#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

function checkElasticSearchService() {
  curl --output ~/.bash_utilities/src/bashcustomize/elasticsearch_last_test_result -XGET "http://localhost:9200/_cat/health?v&pretty" 2>/dev/null
  if [ "$?" -eq 0 ]; then
    echo 1
  else
    echo 0
  fi
}

function startElasticsearchService() {
  printInfoMessage "Starting Elasticsearch Service"
  if [ $(checkElasticSearchService) -eq 1 ]; then
    printInfoMessage "Service already running" 1
  else
    elasticsearch -d -p pid
    while [ $(checkElasticSearchService) -eq 0 ]; do
      printInfoMessage "Testing service status..." && sleep 5
    done
    printInfoMessage "Service running" 1
  fi
}

function stopElasticSearchService() {
  # $1 elasticsearch path
  printInfoMessage "Stopping Elasticsearch Service"
  if [ -f "$1"/pid ]; then
    find "$1" -type f -name pid -exec pkill -F {} +
    printInfoMessage "Service stopped" 1
  else
    printInfoMessage "Service was not running" 1
  fi
}

function elasticsearchServiceStatus() {
  if [ $(checkElasticSearchService) -eq 1 ]; then
    printInfoMessage "Service is running" 1
  else
    printInfoMessage "Service is stopped" 1
  fi
}
