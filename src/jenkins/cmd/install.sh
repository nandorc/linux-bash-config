#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_installed installed_version is_correct_version tmp res_cod

# Check options
service_name=jenkins
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "JENKINS SETUP" "${spaces}" 0

# Check installed service
tmp=$(docker --version 2>&1)
[ $? -ne 0 ] && genericException "Jenkins couldn't be installed because docker is not installed" 0 "${spaces}"
[ $(basher docker:status --output bool) -eq 0 ] && genericException "Jenkins couldn't be installed because docker is not running" 0 "${spaces}"
installed_version=$(docker image ls -a | grep "jenkins/jenkins" 2>&1)
[ $? -eq 0 ] && is_installed=1 || is_installed=0
[ -z "$(echo "${installed_version}" | grep "lts-jdk11")" ] && is_correct_version=0 || is_correct_version=1

# Install service if necessary
if [ ${is_installed} -eq 0 ] || [ ${is_correct_version} -eq 0 ] || [ ${must_force} -eq 1 ]; then
    if [ ${is_installed} -eq 1 ]; then
        if [ ${is_correct_version} -eq 0 ] || [ ${must_force} -eq 1 ]; then
            [ ${must_force} -eq 1 ] && genericWarnMessage "Jenkins will be forced installed" 0 0 || genericWarnMessage "Jenkins version is wrong" 0 0
            # Remove container if exists
            if [ -n "$(docker container ls -a | grep "jenkins")" ]; then
                genericExecutionMessage "Trying to remove Jenkins docker container...\c" 0 0
                tmp=$(docker container stop jenkins) && tmp=$(docker container rm jenkins)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Jenkins docker container can't be removed" 0 "${spaces}"
                responseString "${res_cod}"
            fi
            # Remove image if exists
            if [ ${is_correct_version} -eq 1 ]; then
                genericExecutionMessage "Trying to remove Jenkins docker image...\c" 0 0
                tmp=$(docker image rm jenkins/jenkins:lts-jdk11)
                res_cod=$?
                [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Jenkins docker image can't be removed" 0 "${spaces}"
                responseString "${res_cod}"
            fi
        fi
    fi
    # 1. Pull Jenkins docker image
    genericExecutionMessage "Trying to pull Jenkins docker image...\c" 0 0
    tmp=$(docker pull jenkins/jenkins:lts-jdk11)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Jenkins docker image can't be pulled" 0 "${spaces}"
    responseString "${res_cod}"
    # 2. Create Jenkins docker container
    genericExecutionMessage "Trying to create Jenkins docker container...\c" 0 0
    tmp=$(docker container create --name jenkins -p 8081:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11)
    res_cod=$?
    [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Jenkins docker container can't be created" 0 "${spaces}"
    responseString "${res_cod}"
else
    genericInfoMessage "Jenkins is already installed" 0 0
fi

# Restart service
basher jenkins:restart --no-spaces
[ ${spaces} -eq 1 ] && echo ""
