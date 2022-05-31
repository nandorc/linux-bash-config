#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/flaghandler.sh

# Check parameters
declare service_name options spaces is_compact tmp res_cod
service_name=apache
options=$*
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Check and start service if necessary
[ $(basher "${service_name}":status --output bool) -eq 1 ] && genericInfoMessage "${service_name} service is currently running" "${spaces}" "${spaces}" && exit 0
mayNeedSudoMessage "${spaces}" 0 "${is_compact}"
sudo echo -e "$(genericExecutionMessage "Trying to start ${service_name} service..." 0 0)\c"
if [ $? -eq 0 ]; then
    tmp=$(sudo service apache2 start 2>&1)
    res_cod=$?
    wrap "$(responseString ${res_cod})" 0 "${spaces}" 0 0 && exit ${res_cod}
else
    noSudoPrivilegesException 0 ${spaces}
fi
