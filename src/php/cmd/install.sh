#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_compact is_installed is_correct_version installed_version tmp res_cod settings setting ini_file_dir current_value modules module

# Check options
service_name=php
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "PHP V7.4.X SETUP" "${spaces}" 0

# Check installed version
is_installed=0 && is_correct_version=1 && installed_version=$(php -v 2>&1)
[ $? -eq 0 ] && is_installed=1
[ ${is_installed} -eq 1 ] && [ -z "$(echo "${installed_version}" | grep "PHP 7.4")" ] && is_correct_version=0

# Set forced installation
[ ${must_force} -eq 1 ] && is_installed=0 && is_correct_version=0

# Install if necessary
mayNeedSudoMessage 0 0 "${is_compact}"
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ]; then
    [ ${must_force} -eq 1 ] && genericWarnMessage "PHP will be forced installed" 0 0
    [ ${must_force} -eq 0 ] && [ ${is_correct_version} -eq 0 ] && genericWarnMessage "PHP version is wrong" 0 0
    if [ ${is_correct_version} -eq 0 ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to remove PHP version installed..." 0 0)\c"
        if [ $? -eq 0 ]; then
            # Remove old versions
            tmp=$(sudo apt-get -y purge php* 2>&1) && tmp=$(sudo apt-get -y purge php7* 2>&1) && tmp=$(sudo apt-get -y purge php8* 2>&1) && tmp=$(sudo apt-get -y autoremove 2>&1)
            res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "PHP couldn't be removed so install process was aborted" 0 "{spaces}"
            # Remove php folder
            tmp=$(sudo rm -rf /etc/php 2>&1)
            res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "PHP folder couldn't be removed so install process was aborted" 0 "{spaces}"
            responseString "${res_cod}"
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    sudo echo -e "$(genericExecutionMessage "Trying to install PHP v7.4.x..." 0 0)\c"
    if [ $? -eq 0 ]; then
        # Actualizar listado de paquetes
        tmp=$(sudo apt-get update 2>&1)
        res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "$(color cyan)apt$(color) packages can't be updated" 0 "{spaces}"
        # Install/Update needed packages
        tmp=$(sudo apt-get -y install software-properties-common 2>&1)
        res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Needed packages can't be installed or updated" 0 "{spaces}"
        # Add php and apache repositories
        tmp=$(sudo add-apt-repository -y ppa:ondrej/php 2>&1) && tmp=$(sudo add-apt-repository -y ppa:ondrej/apache2 2>&1) && tmp=$(sudo apt-get update 2>&1)
        res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Needed repositories can't be included" 0 "{spaces}"
        # Install PHP version
        tmp=$(sudo apt-get -y install php7.4 2>&1)
        res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "PHP can't be installed" 0 "{spaces}"
        tmp=$(php -v 2>&1)
        res_cod=$? && [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "PHP install check failed" 0 "{spaces}"
        [ -z "$(echo "${tmp}" | grep "PHP 7.4")" ] && responseString "${res_cod}" && genericException "PHP was installed but version isn't v7.4.x" 0 "${spaces}"
        responseString "${res_cod}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
else
    genericInfoMessage "PHP v7.4.x is already installed" 0 0
fi

# Intall recommended modules
modules=(php7.4-bcmath php7.4-common php7.4-curl php7.4-xml php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-soap php7.4-zip php7.4-imagick php7.4-mcrypt php7.4-ssh2 php-mysql)
for module in "${modules[@]}"; do
    sudo echo -e "$(genericExecutionMessage "Trying to install/update $(color cyan)${module}$(color) package..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo apt-get -y install "${module}" 2>&1)
        responseString $?
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
done

# Set recommended configurations
ini_file_dir=/etc/php/7.4/apache2/php.ini
[ ! -f "${ini_file_dir}" ] && genericException "Can't find php.ini file to set recommended configurations" 0 "${spaces}"
settings=("date.timezone=America/Bogota" "max_execution_time=120" "memory_limit=2G" "post_max_size=64M" "upload_max_filesize=64M" "max_input_time=60" "max_input_vars=3000" "realpath_cache_size=10M" "realpath_cache_ttl=7200" "opcache.save_comments=1")
for setting in "${settings[@]}"; do
    setting=(${setting//=/ })
    current_value=$(cat "${ini_file_dir}" | grep "^${setting[0]}")
    if [ -n "${current_value}" ]; then
        current_value=(${current_value//=/ }) && current_value=${current_value[1]}
        [ "${current_value}" == "${setting[1]}" ] && genericInfoMessage "${setting[0]} is already setted to ${setting[1]}" 0 0 && continue
        tmp=$(sudo sed -i -e "s|^${setting[0]}\(.*\)|${setting[0]} = ${setting[1]}|" "${ini_file_dir}" 2>&1)
        res_cod=$?
    else
        current_value=$(cat "${ini_file_dir}" | grep "^;${setting[0]}")
        [ -z "${current_value}" ] && genericErrorMessage "Can't find ${setting[0]} to set it as ${setting[1]}" 0 0 && continue
        tmp=$(sudo sed -i -e "s|^;${setting[0]}\(.*\)|${setting[0]} = ${setting[1]}|" "${ini_file_dir}" 2>&1)
        res_cod=$?
    fi
    [ ${res_cod} -eq 0 ] && genericInfoMessage "${setting[0]} was settet to ${setting[1]}" 0 0 && continue
    genericErrorMessage "Couldn't set ${setting[0]} to ${setting[1]}" 0 0
done

# Install composer v2.x if necessary
installed_version=$(composer --version 2>&1)
[ $? -eq 0 ] && is_installed=1 || is_installed=0
is_correct_version=1
[ ${is_installed} -eq 1 ] && [ -z "$(echo "${installed_version}" | grep "version 2")" ] && is_correct_version=0
[ ${must_force} -eq 1 ] && is_installed=0 && is_correct_version=0
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ]; then
    [ ${must_force} -eq 1 ] && genericWarnMessage "Composer will be forced installed" 0 0
    [ ${must_force} -eq 0 ] && [ ${is_correct_version} -eq 0 ] && genericWarnMessage "Composer version is wrong" 0 0
    if [ ${is_correct_version} -eq 0 ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to remove Composer version installed..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo rm -rf /usr/local/bin/composer 2>&1)
            res_cod=$?
            responseString ${res_cod}
            [ ${res_cod} -ne 0 ] && genericException "Composer couldn't be removed so install process was aborted" 0 "${spaces}"
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    sudo echo -e "$(genericExecutionMessage "Trying to install Composer v2.x..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo ~/.basher/src/php/lib/composer-install.sh 2>&1)
        responseString $?
        installed_version=$(composer --version 2>&1)
        [ $? -eq 0 ] && is_installed=1
        [ ${is_installed} -eq 0 ] && genericException "Composer couldn't be installed" 0 "${spaces}"
        [ -z "$(echo "${installed_version}" | grep "version 2")" ] && genericException "Composer was installed but version isn't v2.x" 0 "${spaces}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
else
    genericInfoMessage "Composer v2.x is already installed" 0 0
fi

# Finish installation
installed_version=$(apache2 -v 2>&1)
[ $? -eq 0 ] && basher apache:restart --no-spaces --compact
[ ${spaces} -eq 1 ] && echo ""
