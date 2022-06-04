#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options output spaces bool_status http_response_code
service_name=elasticsearch
options=$*
output=$(getFlagValue --output ${options}) && options=$(pruneFlagValue --output ${options})
[ "${output}" != "string" ] && [ "${output}" != "bool" ] && [ "${output}" != "response" ] && output=string
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Get response from elasticsearch
[ ! -d ~/.basher/src/elasticsearch/var ] && mkdir -p ~/.basher/src/elasticsearch/var
http_response_code="000"
while [ "${http_response_code}" == "000" ]; do
    rm -f ~/.basher/src/elasticsearch/var/http_response
    http_response_code=$(curl -s -w '%{http_code}' -o ~/.basher/src/elasticsearch/var/http_response -X GET 'http://localhost:9200/_cat/health?v&pretty')
    [ $? -eq 7 ] && break || sleep 1
done

# Get boolean service status
[ "${http_response_code}" == "200" ] && bool_status=1 || bool_status=0

# Return bool status if requested
[ "${output}" == "bool" ] && echo ${bool_status} && exit

# Return string or response status
if [ "${output}" == "response" ] && [ ${bool_status} -eq 1 ]; then
    wrap "$(cat ~/.basher/src/elasticsearch/var/http_response)" "${spaces}" "${spaces}" 0 0
elif [ "${output}" == "response" ]; then
    genericErrorMessage "elasticsearch service doesn't emit a response" "${spaces}" "${spaces}"
elif [ ${bool_status} -eq 1 ]; then
    wrap "$(color green)[RUNNING] $(color cyan) ${service_name} service$(color)" "${spaces}" "${spaces}" 0 0
else
    wrap "$(color red)[STOPED]  $(color cyan) ${service_name} service$(color)" "${spaces}" "${spaces}" 0 0
fi
