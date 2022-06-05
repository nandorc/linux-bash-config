#!/bin/bash

# Dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Declare variables
declare service_name options must_force spaces is_compact is_installed installed_version tmp res_cod

# Check options
service_name=docker
options=$*
must_force=$(hasFlag --force ${options}) && options=$(pruneFlag --force ${options})
spaces=$(hasFlag --no-spaces ${options}) && options=$(pruneFlag --no-spaces ${options})
[ ${spaces} -eq 1 ] && spaces=0 || spaces=1
is_compact=$(hasFlag --compact ${options}) && options=$(pruneFlag --compact ${options})
[ -n "${options}" ] && noValidOptionsException "${service_name}" "${spaces}" "${spaces}"

# Define heading
commandBlockHeading "DOCKER SETUP" "${spaces}" 0

# Check installed service
installed_version=$(docker --version 2>&1)
[ $? -eq 0 ] && is_installed=1 || is_installed=0

# Install service if necessary
mayNeedSudoMessage 0 0 "${is_compact}"
if [ ${is_installed} -eq 0 ] || [ ${must_force} -eq 1 ]; then
    if [ ${is_installed} -eq 1 ] && [ ${must_force} -eq 1 ]; then
        genericWarnMessage "Docker will be forced installed" 0 0
        sudo echo -e "$(genericExecutionMessage "Trying to remove Docker version installed..." 0 0)\c"
        if [ $? -eq 0 ]; then
            tmp=$(sudo apt-get -y purge docker docker-ce docker-ce-cli docker-engine docker.io docker-compose-plugin containerd containerd.io runc 2>&1) && tmp=$(sudo apt-get -y autoremove 2>&1) && tmp=$(sudo rm -rf /var/lib/docker 2>&1) && tmp=$(sudo rm -rf /var/lib/containerd 2>&1)
            res_cod=$?
            responseString ${res_cod}
            [ ${res_cod} -ne 0 ] && genericException "Docker couldn't be removed so install process was aborted" 0 "${spaces}"
        else
            noSudoPrivilegesException 0 "${spaces}"
        fi
    fi
    sudo echo -e "$(genericExecutionMessage "Trying to install Docker..." 0 0)\c"
    if [ $? -eq 0 ]; then
        # 1. Update apt and install needed packages
        tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install ca-certificates curl gnupg lsb-release 2>&1)
        res_cod=$?
        [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Failed to install necessary packages for Docker" 0 "${spaces}"
        # 2. Drop GPG key if exists
        if [ -f /etc/apt/keyrings/docker.gpg ]; then
            tmp=$(sudo rm -rf /etc/apt/keyrings/docker.gpg 2>&1)
            res_cod=$?
            [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Failed to remove old Docker GPG key" 0 "${spaces}"
        fi
        # 3. Add docker GPG key
        tmp=$(sudo mkdir -p /etc/apt/keyrings 2>&1) && tmp=$(curl -fsSL https://download.docker.com/linux/ubuntu/gpg |& sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 2>&1)
        res_cod=$?
        [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Failed to add Docker GPG key" 0 "${spaces}"
        # 4. Adjust GPG key permissions
        tmp=$(sudo chmod a+r /etc/apt/keyrings/docker.gpg)
        res_cod=$?
        [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Failed to adjust permissions for Docker GPG key" 0 "${spaces}"
        # 5. Set up repository
        tmp=$(echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |& sudo tee /etc/apt/sources.list.d/docker.list 2>&1)
        res_cod=$?
        [ ${res_cod} -ne 0 ] && responseString "${res_cod}" && genericException "Failed to set up docker repository" 0 "${spaces}"
        # 6. Install docker engine
        tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin)
        res_cod=$? && responseString "${res_cod}"
        [ ${res_cod} -ne 0 ] && genericException "Failed to install Docker components" 0 "${spaces}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
else
    genericInfoMessage "Docker is already installed" 0 0
fi

# Create docker group if not exists
if [ -z "$(cat /etc/group | grep "^docker")" ]; then
    sudo echo -e "$(genericExecutionMessage "Trying to create $(color cyan)docker$(color) group..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo groupadd docker 2>&1)
        res_cod=$? && responseString "${res_cod}"
        [ ${res_cod} -ne 0 ] && genericException "Failed to create $(color cyan)docker$(color) group" 0 "${spaces}"
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
fi

# Create docker group if not exists
if [ -z "$(groups $USER | grep docker)" ]; then
    sudo echo -e "$(genericExecutionMessage "Trying to add $(color cyan)${USER}$(color) to $(color cyan)docker$(color) group..." 0 0)\c"
    if [ $? -eq 0 ]; then
        tmp=$(sudo usermod -aG docker $USER 2>&1)
        res_cod=$? && responseString "${res_cod}"
        [ ${res_cod} -ne 0 ] && genericException "Failed adding $(color cyan)${USER}$(color) to $(color cyan)docker$(color) group" 0 "${spaces}"
        genericInfoMessage "Your need to reload your terminal in order to apply settings" 0 0
        genericInfoMessage "If you want you can reload your terminal using $(color yellow)newgrp docker$(color)" 0 0
    else
        noSudoPrivilegesException 0 "${spaces}"
    fi
fi

# Restart service
basher docker:restart --no-spaces --compact
[ ${spaces} -eq 1 ] && echo ""
