#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/lib/elasticsearch.sh

alias elasticsearch_start="startElasticsearchService"
alias elasticsearch_stop="stopElasticSearchService '$custom_bash_elasticsearch_path'"
alias elasticsearch_restart="elasticsearch_stop && elasticsearch_start"
alias elasticsearch_status="elasticsearchServiceStatus"
