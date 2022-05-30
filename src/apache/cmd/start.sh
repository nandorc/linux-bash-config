#!/bin/bash

# Load dependencies
source ~/.basher/lib/servicehandler.sh
source ~/.basher/lib/flagger.sh

# Check parameters
declare service_name="apache"
declare options=$*
declare no_spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
declare is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException ${service_name} ${no_spaces} ${no_spaces}

# Check and start service if necessary
[ $(basher "${service_name}":status --output bool) -eq 1 ] && wrap "$(color light-blue)INF~$(color) ${service_name} service is currently running" ${no_spaces} ${no_spaces} 0 0 && exit
wrap "$(color light-blue)INF~$(color) You may need to type your $(color cyan)sudo$(color) password to continue" ${no_spaces} 1 ${is_compact} 0
sudo echo -e "EXE~ Trying to start ${service_name} service...\c"
if [ $? -eq 0 ]; then
    tmp=$(sudo service apache2 start 2>&1)
    res_cod=$?
    wrap "$(getResponseMessage ${res_cod})" 1 ${no_spaces} 0 0 && exit ${res_cod}
else
    noSudoPrivilegesException 1 ${no_spaces}
fi
