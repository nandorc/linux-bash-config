#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/commands.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

alias bc:elasticsearch:start="wrapCommand --colored 'Starting elasticseach service...' 'startElasticsearchService' both"
alias bc:elasticsearch:stop="wrapCommand --colored 'Stopping elasticsearch service...' 'stopElasticSearchService' both"
alias bc:elasticsearch:restart="wrapCommand --colored 'Restarting elasticsearch service...' 'restartElasticSearchService' both"
alias bc:elasticsearch:status="wrapCommand --colored 'Checking elasticsearch service...' 'checkElasticSearchService string' both"
alias bc:elasticsearch:ping="wrapCommand --colored 'Sending request to elasticseach service...' 'checkElasticSearchService response' both"
