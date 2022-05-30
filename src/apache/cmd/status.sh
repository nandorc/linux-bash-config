#!/bin/bash

# Load dependencies
source ~/.basher/lib/servicehandler.sh
source ~/.basher/lib/flagger.sh

# Check parameters
declare service_name="apache"
declare options=$*
declare output=$(getFlagValue --output ${options}) && options=$(pruneFlagValue --output ${options})
declare no_spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ -n "${options}" ] && noValidOptionsException ${service_name} ${no_spaces} ${no_spaces}
[ "${output}" != "string" ] && [ "${output}" != "bool" ] && output=string

# Get boolean service status
declare bool_status=1
declare is_running=$(service apache2 status |& grep "is running")
[ -z "${is_running}" ] && bool_status=0

# Return bool status if requested
[ "${output}" = "bool" ] && echo ${bool_status} && exit

# Return string status
[ ${bool_status} -eq 1 ] && wrap "$(color green)[RUNNING] $(color)\c" ${no_spaces} 1 0 0
[ ${bool_status} -eq 0 ] && wrap "$(color red)[STOPED]  $(color)\c" ${no_spaces} 1 0 0
wrap "$(color cyan) ${service_name} service$(color)" 1 ${no_spaces} 0 0
