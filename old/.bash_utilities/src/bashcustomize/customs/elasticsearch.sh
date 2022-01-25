#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/lib/elasticsearch.sh

alias elasticsearch_start="startElasticsearchService both"
alias elasticsearch_stop="stopElasticSearchService both"
alias elasticsearch_restart="restartElasticSearchService both"
alias elasticsearch_status="checkElasticSearchService string both"
alias elasticsearch_ping="checkElasticSearchService response both"
