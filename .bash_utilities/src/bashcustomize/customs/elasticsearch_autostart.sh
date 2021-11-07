#!/bin/bash

source ~/.bash_utilities/lib/messages.sh
source ~/.bash_utilities/src/bashcustomize/lib/elasticsearch.sh

if [ $(checkElasticSearchService) -eq 0 ]; then
  printInfoMessage "Elasticsearch service is stopped. Let's start it."
  startElasticsearchService
  sleep 2
fi
