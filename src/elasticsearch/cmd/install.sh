#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_compact is_installed installed_version is_correct_version tmp res_cod

# Check options
service_name=elasticsearch
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "ELASTICSEARCH v7.10.x SETUP" "${spaces}" 0

# Check installed service
tmp=$(docker --version 2>&1)
[ $? -ne 0 ] && genericException "Elasticsearch couldn't be installed because docker is not installed" 0 "${spaces}"
[ $(basher docker:status --output bool) -eq 0 ] && genericException "Elasticsearch couldn't be installed because docker is not running" 0 "${spaces}"
installed_version=$(docker image ls -a | grep "docker.elastic.co/elasticsearch/elasticsearch" 2>&1)
[ $? -eq 0 ] && is_installed=1 || is_installed=0
[ -z "$(echo "${installed_version}" | grep "7.10")" ] && is_correct_version=0 || is_correct_version=1

# Install service if necessary
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ] || [ ${must_force} -eq 1 ]; then
    if [ ${is_installed} -eq 1 ]; then
        if [ ${is_correct_version} -eq 0 ] || [ ${must_force} -eq 1 ]; then
            [ ${must_force} -eq 1 ] && genericWarnMessage "Elasticsearch will be forced installed" 0 0 || genericWarnMessage "Elasticsearch version is wrong" 0 0
            # Remove container if exists
            if [ -n "$(docker container ls -a | grep "elasticsearch7.10")" ]; then
                genericExecutionMessage "Trying to remove Elasticsearch docker container...\c" 0 0
                tmp=$(docker container stop elasticsearch7.10) && tmp=$(docker container rm elasticsearch7.10)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Elasticsearch docker container can't be removed" 0 "${spaces}"
                responseString "${res_cod}"
            fi
            # Remove image if exists
            if [ ${is_correct_version} -eq 1 ]; then
                genericExecutionMessage "Trying to remove Elasticsearch docker image...\c" 0 0
                tmp=$(docker image rm docker.elastic.co/elasticsearch/elasticsearch:7.10.2)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Elasticsearch docker image can't be removed" 0 "${spaces}"
                responseString "${res_cod}"
            fi
        fi
    fi
    # 1. Pull elasticsearch docker image
    genericExecutionMessage "Trying to pull Elasticsearch docker image...\c" 0 0
    tmp=$(docker pull docker.elastic.co/elasticsearch/elasticsearch:7.10.2)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Elasticsearch docker image can't be pulled" 0 "${spaces}"
    responseString "${res_cod}"
    # 2. Create elasticsearch docker container
    genericExecutionMessage "Trying to create Elasticsearch docker container...\c" 0 0
    tmp=$(docker container create --name elasticsearch7.10 -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.10.2)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Elasticsearch docker container can't be created" 0 "${spaces}"
    responseString "${res_cod}"
else
    genericInfoMessage "Elasticsearch is already installed" 0 0
fi

# Set Apache proxy for elasticsearch
tmp=$(apache2 -v 2>&1)
if [ $? -eq 0 ]; then
    mayNeedSudoMessage 0 0 "${is_compact}"
    [ -z "$(ls /etc/apache2/mods-available |& grep "^proxy_http.load")" ] && genericException "Apache $(color cyan)proxy_http$(color) module is not available" 0 "${spaces}"
    if [ -z "$(ls /etc/apache2/mods-enabled |& grep "^proxy_http.load")" ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to enable Apache $(color cyan)proxy_http$(color) module..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo a2enmod proxy_http 2>&1)
            responseString $?
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    else
        genericInfoMessage "Apache $(color cyan)proxy_http$(color) module is already enabled" 0 0
    fi
    if [ ! -f /etc/apache2/sites-enabled/elasticsearch-proxy.conf ]; then
        sudo echo -e "$(genericExecutionMessage "Trying to set Apache proxy for Elasticsearch..." 0 0)\c"
        res_cod=$?
        if [ ${res_cod} -eq 0 ]; then
            if [ ! -f /etc/apache2/sites-available/elasticsearch-proxy.conf ]; then
                tmp=$(sudo cp ~/.basher/src/elasticsearch/templates/elasticsearch-proxy.conf /etc/apache2/sites-available/ 2>&1)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericErrorMessage "Apache proxy for Elasticsearch .conf file can't be placed" 0 0
            fi
            if [ ${res_cod} -eq 0 ]; then
                tmp=$(sudo chown root:root /etc/apache2/sites-available/elasticsearch-proxy.conf 2>&1) && tmp=$(sudo chmod 644 /etc/apache2/sites-available/elasticsearch-proxy.conf 2>&1)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericErrorMessage "Apache proxy for Elasticsearch .conf file permissions can't be setted" 0 0
            fi
            if [ ${res_cod} -eq 0 ]; then
                tmp=$(sudo a2ensite elasticsearch-proxy.conf 2>&1)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericErrorMessage "Apache proxy for Elasticsearch can't be enabled" 0 0
            fi
            [ ${res_cod} -eq 0 ] && responseString "${res_cod}" && basher apache:restart --no-spaces --compact
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    else
        genericInfoMessage "Apache proxy for Elasticsearch is already setted" 0 0
    fi
else
    genericWarnMessage "Apache proxy for Elasticsearch can't be setted" 0 0
fi

# Restart service
basher elasticsearch:restart --no-spaces
[ ${spaces} -eq 1 ] && echo ""
