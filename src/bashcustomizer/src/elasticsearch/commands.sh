#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/lib/ext/dsoft/inihandler.sh

# Check if elasticsearch service is responding
# $1 output type. int on empty or invalid.
#   'string' for a text status output
#   'response' to output http_response if available
#   'int' for a numeric status output
#     -1 : service response error
#      0 : service stopped, unavailable or unreachable
#      1 : service running
function checkElasticSearchService() {
    http_response_code=$(curl -s -w '%{http_code}' -o ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/http_response -X GET 'http://localhost:9200/_cat/health?v&pretty')
    if [ "$http_response_code" = "000" ]; then
        int_status=0 && string_status="Elasticsearch service is stopped, unavailable or is unreachable."
    elif [ "$http_response_code" = "200" ]; then
        int_status=1 && string_status="Elasticsearch service is running."
    else
        int_status=-1 && string_status="Elasticsearch service is running but report a $http_response_code response code."
    fi
    if [ "$1" = "string" ]; then
        printMessage "$string_status"
    elif [ "$1" = "response" ]; then
        if [ $int_status -eq 1 ]; then
            if [ -f ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/http_response ]; then
                printMessage "Elasticsearch service response:" after
                cat ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/http_response
            else
                printMessage "Elasticsearch service has no response."
            fi
        else
            printMessage "Elasticsearch service has no response. $string_status"
        fi
    else
        echo "$int_status"
    fi
    rm -f ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/http_response
    unset http_response_code int_status string_status
}

# Start elasticsearch service
function startElasticsearchService() {
    if [ $(checkElasticSearchService) -ne 1 ]; then
        elasticsearch -d -p pid
        printMessage "Testing elasticsearch service..."
        while [ $(checkElasticSearchService) -ne 1 ]; do
            sleep 2
        done
        if [ ! -f ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid ]; then
            touch ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid
        fi
        cat "$(getINIVar ~/.bash_utilities/src/bashcustomizer/etc/vars.ini elasticsearch_path)"/pid >~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid
    fi
    printMessage "Elasticsearch is running."
}

# Stop elasticsearch service
function stopElasticSearchService() {
    if [ $(checkElasticSearchService) -eq 1 ]; then
        if [ ! -f ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid ]; then
            printWarningMessage "Elasticsearch was not started by bashcustomizer so system was not able to stop service."
        else
            java_services=$(pgrep java)
            service_pid=$(echo $java_services | grep "^$(cat ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid)$")
            if [ -z "$service_pid" ] && [ ! -z "$java_services" ]; then
                printWarningMessage "Elasticsearch service pid doesn't match so bashcustomizer is not able to stop service."
            elif [ -z "$java_services" ]; then
                printWarningMessage "No java services currently running so bashcustomizer system is not able to stop service."
            else
                pkill -F ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid
                printMessage "Testing elasticsearch service..."
                while [ $(checkElasticSearchService) -eq 1 ]; do
                    sleep 2
                done
                rm -f ~/.bash_utilities/src/bashcustomizer/src/elasticsearch/pid
                printMessage "Elasticsearch stopped."
            fi
            unset service_pid java_services
        fi
    else
        printMessage "Elasticsearch not running or not responding."
    fi
}

# Restart elasticsearch service
function restartElasticSearchService() {
    stopElasticSearchService
    if [ $(checkElasticSearchService) -eq 1 ]; then
        printWarningMessage "Bashcustomizer was not able to restart elasticsearch service."
    else
        startElasticsearchService
    fi
}
