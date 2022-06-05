#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options spaces is_compact res_cod tmp
service_name=elasticsearch
options=$*
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

genericExecutionMessage "Trying to restart ${service_name} service...\c" "${spaces}" 0
if [ $(basher "${service_name}":status --output bool) -eq 1 ]; then
    tmp=$(basher "${service_name}":stop 2>&1)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "${service_name} couldn't be stopped so restart process was aborted" 0 "${spaces}"
fi
tmp=$(basher "${service_name}":start 2>&1)
res_cod=$?
[ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "${service_name} couldn't be started so restart process was aborted" 0 "${spaces}"
wrap "$(responseString "${res_cod}")" 0 "${spaces}" 0 0 && exit 0
