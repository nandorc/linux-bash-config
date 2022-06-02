#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options spaces is_compact
service_name=lamp
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Start services
commandBlockHeading "LAMP SERVICES SETUP" "${spaces}" 0
mayNeedSudoMessage 0 1 "${is_compact}"
if [ ${must_force} -eq 1 ]; then
    basher apache:install --no-spaces --compact --force
    echo "" && basher mysql:install --no-spaces --compact --force
    echo "" && basher php:install --no-spaces --compact --force
else
    basher apache:install --no-spaces --compact
    echo "" && basher mysql:install --no-spaces --compact
    echo "" && basher php:install --no-spaces --compact
fi
[ ${spaces} -eq 1 ] && echo ""
