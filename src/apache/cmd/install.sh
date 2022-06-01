#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_compact is_installed is_correct_version installed_version tmp res_cod apache_modules module is_available is_enabled

# Check options
service_name=apache
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "APACHE WEBSERVER V2.4.X SETUP" "${spaces}" 0

# Check apache v2.4.x
is_installed=0 && is_correct_version=1 && installed_version=$(apache2 -v 2>&1)
[ $? -eq 0 ] && is_installed=1
[ ${is_installed} -eq 1 ] && [ -z "$(echo "${installed_version}" | grep Apache/2.4)" ] && is_correct_version=0

# Set forced installation
[ ${must_force} -eq 1 ] && is_installed=0 && is_correct_version=0

# Install apache v2.4.x if necessary
mayNeedSudoMessage 0 0 "${is_compact}"
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ]; then
    [ ${must_force} -eq 1 ] && genericWarnMessage "Apache webserver will be forced installed" 0 0
    [ ${must_force} -eq 0 ] && [ ${is_correct_version} -eq 0 ] && genericWarnMessage "Apache webserver version is wrong" 0 0
    if [ ${is_correct_version} -eq 0 ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to remove Apache webserver version installed..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo apt-get purge -y apache2 2>&1) && tmp=$(sudo apt-get purge -y apache2* 2>&1) && tmp=$(sudo apt-get autoremove -y 2>&1)
            res_cod=$?
            responseString ${res_cod}
            [ ${res_cod} -ne 0 ] && genericException "Apache webserver couldn't be removed so install process was aborted" 0 "${spaces}"
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    sudo echo -e "$(genericExecutionMessage "Trying to install Apache webserver v2.4.x..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install apache2 2>&1)
        responseString $?
        installed_version=$(apache2 -v 2>&1)
        [ $? -eq 0 ] && is_installed=1
        [ ${is_installed} -eq 0 ] && genericException "Apache webserver couldn't be installed" 0 "${spaces}"
        [ -z "$(echo "${installed_version}" | grep Apache/2.4)" ] && genericException "Apache webserver was installed but version isn't v2.4.x" 0 "${spaces}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
else
    genericInfoMessage "Apache webserver v2.4.x is already installed" 0 0
fi

# Enable recommended modules
apache_modules=(deflate expires headers rewrite security2 ssl)
for module in "${apache_modules[@]}"; do
    is_available=$(ls /etc/apache2/mods-available |& grep "^${module}.load")
    if [ -z "${is_available}" ] && [ "${module}" == "security2" ]; then
        # Install mod-security2
        sudo echo -e "$(genericExecutionMessage "Trying to install Apache security2 module..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install libapache2-mod-security2 2>&1)
            responseString $?
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    [ "${module}" == "security2" ] && is_available=$(ls /etc/apache2/mods-available |& grep "^${module}.load")
    [ -z "${is_available}" ] && genericErrorMessage "Apache $(color cyan)${module}$(color) module is not available" 0 0 && continue
    is_enabled=$(ls /etc/apache2/mods-enabled |& grep "^${module}.load")
    if [ -z "${is_enabled}" ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to enable Apache $(color cyan)${module}$(color) module..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo a2enmod ${module} 2>&1)
            responseString $?
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    else
        genericInfoMessage "Apache $(color cyan)${module}$(color) module is already enabled" 0 0
    fi
done

# Restart apache service
basher apache:restart --no-spaces --compact
[ ${spaces} -eq 1 ] && echo ""
