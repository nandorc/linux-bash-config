#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options spaces is_compact
service_name=magento
options=$*
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Start services
commandBlockHeading "Magento Services Stop" "${spaces}" 0
mayNeedSudoMessage 0 0 "${is_compact}"
basher apache:stop --no-spaces --compact
basher mysql:stop --no-spaces --compact
basher docker:stop --no-spaces --compact
basher elasticsearch:stop --no-spaces
[ ${spaces} -eq 1 ] && echo ""
