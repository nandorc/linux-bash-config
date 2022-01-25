#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# $1 input spacing
function transformBeforeSpacing() {
    if [ "$1" = "both" ]; then
        echo before
    elif [ "$1" = "after" ]; then
        echo none
    else
        echo "$1"
    fi
}

# $1 input spacing
function transformAfterSpacing() {
    if [ "$1" = "both" ] || [ "$1" = "after" ]; then
        echo after
    else
        echo none
    fi
}

# $1 input spacing
function applyAfterTransformSpacing() {
    if [ "$(transformAfterSpacing "$1")" = "after" ]; then
        echo ""
    fi
}

# $1 output type. int on empty or invalid.
#   'string' for a text status output
#   'response' to output http_response if available
#   'int' for a numeric status output
#     -1 : service response error
#      0 : service stopped, unavailable or unreachable
#      1 : service running
# $2 spacing. For 'string' or 'response' output type. @see source ~/.bash_utilities/lib/ext/dsoft/messages.sh/printMessage
function checkElasticSearchService() {
    http_response_code=$(curl -s -w '%{http_code}' -o ~/.bash_utilities/src/bashcustomize/elasticsearch_http_response -X GET 'http://localhost:9200/_cat/health?v&pretty')
    if [ "$http_response_code" = "000" ]; then
        int_status=0 && string_status="Elasticsearch service is stopped, unavailable or is unreachable."
    elif [ "$http_response_code" = "200" ]; then
        int_status=1 && string_status="Elasticsearch service is running."
    else
        int_status=-1 && string_status="Elasticsearch service is running but report a $http_response_code response code."
    fi
    if [ "$1" = "string" ]; then
        printInfoMessage "$string_status" "$2"
    elif [ "$1" = "response" ]; then
        if [ $int_status -eq 1 ]; then
            if [ -f ~/.bash_utilities/src/bashcustomize/elasticsearch_http_response ]; then
                response_spacing=$(transformBeforeSpacing "$2")
                printInfoMessage "Elasticsearch service response:" "$response_spacing"
                cat ~/.bash_utilities/src/bashcustomize/elasticsearch_http_response
                applyAfterTransformSpacing "$2"
                unset response_spacing
            else
                printInfoMessage "Elasticsearch service has no response." "$2"
            fi
        else
            printInfoMessage "Elasticsearch service has no response. $string_status" "$2"
        fi
    else
        echo "$int_status"
    fi
    rm -f ~/.bash_utilities/src/bashcustomize/elasticsearch_http_response
    unset http_response_code int_status string_status
}

# $1 spacing. @see source ~/.bash_utilities/lib/ext/dsoft/messages.sh/printMessage
function startElasticsearchService() {
    message_spacing=$(transformBeforeSpacing "$1")
    printInfoMessage "Starting elasticsearch service..." "$message_spacing"
    if [ $(checkElasticSearchService) -eq 1 ]; then
        printInfoMessage "Service already running."
    else
        elasticsearch -d -p pid
        printInfoMessage "Testing elasticsearch service status..."
        while [ $(checkElasticSearchService) -ne 1 ]; do
            sleep 2
        done
        if [ ! -f ~/.bash_utilities/src/bashcustomize/elasticsearch_pid ]; then
            touch ~/.bash_utilities/src/bashcustomize/elasticsearch_pid
        fi
        cat "$custom_bash_elasticsearch_path"/pid >~/.bash_utilities/src/bashcustomize/elasticsearch_pid
        printInfoMessage "Elasticsearch service running."
    fi
    applyAfterTransformSpacing "$1"
    unset message_spacing
}

# $1 spacing. @see source ~/.bash_utilities/lib/ext/dsoft/messages.sh/printMessage
function stopElasticSearchService() {
    message_spacing=$(transformBeforeSpacing "$1")
    printInfoMessage "Stopping elasticsearch service..." "$message_spacing"
    if [ $(checkElasticSearchService) -ne 1 ]; then
        printInfoMessage "Elasticsearch service was not running."
    else
        if [ ! -f ~/.bash_utilities/src/bashcustomize/elasticsearch_pid ]; then
            printWarningMessage "Elasticsearch was not started by bashcustomize system so system was not able to stop service."
        else
            java_services=$(pgrep java)
            service_pid=$(echo $java_services | grep "^$(cat ~/.bash_utilities/src/bashcustomize/elasticsearch_pid)$")
            if [ -z "$service_pid" ] && [ ! -z "$java_services" ]; then
                printWarningMessage "Elasticsearch service pid doesn't match so bashcustomize system is not able to stop service."
            elif [ -z "$java_services" ]; then
                printWarningMessage "No java services currently running so bashcustomize system is not abro to stop service."
            else
                pkill -F ~/.bash_utilities/src/bashcustomize/elasticsearch_pid
                printInfoMessage "Testing elasticsearch service status..."
                while [ $(checkElasticSearchService) -eq 1 ]; do
                    sleep 2
                done
                rm -f ~/.bash_utilities/src/bashcustomize/elasticsearch_pid
                printInfoMessage "Elasticsearch service stopped."
            fi
            unset service_pid java_services
        fi
    fi
    applyAfterTransformSpacing "$1"
    unset message_spacing
}

# $1 spacing. @see source ~/.bash_utilities/lib/ext/dsoft/messages.sh/printMessage
function restartElasticSearchService() {
    message_spacing=$(transformBeforeSpacing "$1")
    printInfoMessage "Restarting elasticsearch service..." "$message_spacing"
    stopElasticSearchService
    message_spacing=$(transformAfterSpacing "$1")
    if [ $(checkElasticSearchService) -eq 1 ]; then
        printWarningMessage "Bashcustomize system was not able to restart elasticsearch service." "$message_spacing"
    else
        startElasticsearchService
        printInfoMessage "Elasticsearch service restarted" "$message_spacing"
    fi
    unset message_spacing
}
