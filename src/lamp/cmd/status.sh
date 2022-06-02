#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options output spaces
service_name=lamp
options=$*
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Check services
commandBlockHeading "LAMP Services Status Check" "${spaces}" 0
basher apache:status --no-spaces
basher mysql:status --no-spaces
[ ${spaces} -eq 1 ] && echo ""
