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

# Ask for sudo privileges if necessary to try to restart service
wrap "$(color light-blue)INF~$(color) You may need to type your $(color cyan)sudo$(color) password to continue" ${no_spaces} 1 ${is_compact} 0
sudo echo -e "EXE~ Trying to restart ${service_name} service...\c"
if [ $? -eq 0 ]; then
    declare res_cod=0
    if [ $(basher "${service_name}":status --output bool) -eq 1 ]; then
        tmp=$(basher "${service_name}":stop 2>&1)
        res_cod=$?
        [ ${res_cod} -ne 0 ] && processResponse ${res_cod} && genericException "${service_name} couldn't be stopped so restart process was aborted" 1 ${no_spaces}
    fi
    tmp=$(basher "${service_name}":start 2>&1)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && echo -e "$(getResponseMessage ${res_cod})" && genericException "${service_name} couldn't be started so restart process was aborted" 1 ${no_spaces}
    wrap "$(getResponseMessage ${res_cod})" 1 ${no_spaces} 0 0 && exit
else
    noSudoPrivilegesException 1 ${no_spaces}
fi
