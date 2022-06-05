#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_compact is_installed is_correct_version installed_version tmp res_cod sql_mode current_value

# Check options
service_name=mysql
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "MYSQL SERVER V8.0.X SETUP" "${spaces}" 0

# Check MySQL v8.0.x
is_installed=0 && is_correct_version=1 && installed_version=$(mysql --version 2>&1)
[ $? -eq 0 ] && is_installed=1
[ ${is_installed} -eq 1 ] && [ -z "$(echo "${installed_version}" | grep "Ver 8.0")" ] && is_correct_version=0

# Set forced installation
[ ${must_force} -eq 1 ] && is_installed=0 && is_correct_version=0

# Install mysql v8.0.x if necessary
mayNeedSudoMessage 0 0 "${is_compact}"
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ]; then
    [ ${must_force} -eq 1 ] && genericWarnMessage "MySQL server will be forced installed" 0 0
    [ ${must_force} -eq 0 ] && [ ${is_correct_version} -eq 0 ] && genericWarnMessage "MySQL server version is wrong" 0 0
    if [ ${is_correct_version} -eq 0 ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to remove MySQL server version installed..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo apt-get -y purge mysql* 2>&1) && tmp=$(sudo apt-get -y autoremove 2>&1)
            res_cod=$?
            responseString ${res_cod}
            [ ${res_cod} -ne 0 ] && genericException "MySQL server couldn't be removed so install process was aborted" 0 "${spaces}"
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    sudo echo -e "$(genericExecutionMessage "Trying to install MySQL server v8.0.x..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install mysql-server 2>&1)
        responseString $?
        installed_version=$(mysql --version 2>&1)
        [ $? -eq 0 ] && is_installed=1
        [ ${is_installed} -eq 0 ] && genericException "MySQL server couldn't be installed" 0 "${spaces}"
        [ -z "$(echo "${installed_version}" | grep "Ver 8.0")" ] && genericException "MySQL server was installed but version isn't v8.0.x" 0 "${spaces}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
else
    genericInfoMessage "MySQL server v8.0.x is already installed" 0 0
fi

# Set recommended sql-modes
sql_mode="STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
[ ! -f /etc/mysql/mysql.conf.d/mysqld.cnf ] && genericException "Can't find mysqld.cnf file to set MySQL sql-mode" 0 "${spaces}"
current_value=$(cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep "^sql-mode=" | sed -e "s|sql-mode=||")
[ -n "${current_value}" ] && [ "${current_value}" != "${sql_mode}" ] && genericWarnMessage "MySQL sql-mode differs from recommended value"
if [ "${current_value}" == "${sql_mode}" ]; then
    genericInfoMessage "MySQL sql-mode is already setted" 0 0
else
    sudo echo -e "$(genericExecutionMessage "Trying to set sql-mode..." 0 0)\c"
    if [ $? -eq 0 ]; then
        if [ -z "${current_value}" ]; then
            tmp=$(echo "sql-mode=${sql_mode}" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf 2>&1)
            res_cod=$?
        else
            tmp=$(sudo sed -i -e "s|sql-mode=${current_value}|sql-mode=${sql_mode}|" /etc/mysql/mysql.conf.d/mysqld.cnf)
            res_cod=$?
        fi
        responseString "${res_cod}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
fi

# Change permissions for mysqld run folder
if [ ! -d /run/mysqld ]; then
    genericWarnMessage "Run folder for mysqld doesn't exists" 0 0
    sudo echo -e "$(genericExecutionMessage "Trying to create mysqld run folder..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo mkdir -p /run/mysqld)
        responseString $?
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
fi
sudo echo -e "$(genericExecutionMessage "Trying to set permissions to mysqld run folder..." 0 0)\c"
if [ $? -eq 0 ]; then
    tmp=$(sudo chown mysql:mysql /run/mysqld) && tmp=$(sudo chmod 755 /run/mysqld)
    responseString $?
else
    noSudoPrivilegesException 0 "${spaces}"
fi

# Restart apache service
basher mysql:restart --no-spaces --compact
[ ${spaces} -eq 1 ] && echo ""
