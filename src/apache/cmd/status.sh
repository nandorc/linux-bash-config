#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options output spaces bool_status is_running
service_name=apache
options=$*
output=$(getFlagValue --output ${options}) && options=$(pruneFlagValue --output ${options})
[ "${output}" != "string" ] && [ "${output}" != "bool" ] && output=string
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Get boolean service status
is_running=$(service apache2 status |& grep "is running")
[ -z "${is_running}" ] && bool_status=0 || bool_status=1

# Return bool status if requested
[ "${output}" = "bool" ] && echo ${bool_status} && exit

# Return string status
[ ${bool_status} -eq 1 ] && wrap "$(color green)[RUNNING] $(color)\c" "${spaces}" 0 0 0 || wrap "$(color red)[STOPED]  $(color)\c" "${spaces}" 0 0 0
wrap "$(color cyan) ${service_name} service$(color)" 0 ${spaces} 0 0
