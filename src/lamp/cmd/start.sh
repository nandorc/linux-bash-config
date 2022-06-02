#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options spaces is_compact
service_name=lamp
options=$*
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Start services
commandBlockHeading "LAMP Services Start" "${spaces}" 0
mayNeedSudoMessage 0 0 "${is_compact}"
basher apache:start --no-spaces --compact
basher mysql:start --no-spaces --compact
[ ${spaces} -eq 1 ] && echo ""
