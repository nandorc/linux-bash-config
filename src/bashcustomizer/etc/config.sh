#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/lib/ext/dsoft/inihandler.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh

# Read or initialize variables
printMessage "Reading bashcustomizer variables..."
if [ ! -f ~/.bash_utilities/src/bashcustomizer/etc/vars.ini ]; then
    bashcustomizer init
fi
printMessage "done"

# GIT Customization
bc_gitflow=$(checkCustomization gitflow)
if [ $bc_gitflow -eq 1 ]; then
    includeCustomization gitflow
fi
unset bc_gitflow

# WSL Customization
bc_wsl=$(checkCustomization wsl)
if [ $bc_wsl -eq 1 ]; then
    includeCustomization wsl
fi
unset bc_wsl

# Elasticsearch dependent customizations
bc_elasticsearch=$(checkCustomization elasticsearch)
bc_elasticsearch_autostart=$(checkCustomization elasticsearch_autostart)
bc_magento=$(checkCustomization magento)
bc_magento_autostart=$(checkCustomization magento_autostart)

# Elasticsearch Customization Check
bc_elasticsearch_flag=0
bc_elasticsearch_path=$(getINIVar ~/.bash_utilities/src/bashcustomizer/etc/vars.ini elasticsearch_path)
if [ -n "$bc_elasticsearch_path" ]; then
    if [ -d "$bc_elasticsearch_path"/bin ]; then
        if [[ ! "$PATH" =~ "$bc_elasticsearch_path" ]]; then
            PATH="$PATH:$bc_elasticsearch_path/bin"
        fi
        bc_elasticsearch_flag=1
    else
        post_load_message="$post_load_message[01] Customizations 'elasticsearch', 'elasticsearch_autostart', 'magento' and 'magento_autostart' were skipped due to no /bin folder found at elasticsearch_path."
    fi
elif [ $bc_elasticsearch -eq 1 ] || [ $bc_elasticsearch_autostart -eq 1 ] || [ $bc_magento -eq 1 ] || [ $bc_magento_autostart -eq 1 ]; then
    post_load_message="$post_load_message[02] Customizations 'elasticsearch', 'elasticsearch_autostart', 'magento' and 'magento_autostart' were skipped due to no elasticsearch_path defined. Use 'bashcustomizer set elasticsearch_path path' to define it. "
fi

# Magento Customization - Autostart
if [ $bc_elasticsearch_flag -eq 1 ] && [ $bc_magento_autostart -eq 1 ]; then
    includeCustomization magento_autostart
else
    # LAMP Customization - Autostart
    bc_lamp_autostart=$(checkCustomization lamp_autostart)
    if [ $bc_lamp_autostart -eq 1 ]; then
        includeCustomization lamp_autostart
    else
        # Apache Customization - Autostart
        bc_apache_autostart=$(checkCustomization apache_autostart)
        if [ $bc_apache_autostart -eq 1 ]; then
            includeCustomization apache_autostart
        fi
        unset bc_apache_autostart

        # MySQL Customization - Autostart
        bc_mysql_autostart=$(checkCustomization mysql_autostart)
        if [ $bc_mysql_autostart -eq 1 ]; then
            includeCustomization mysql_autostart
        fi
        unset bc_mysql_autostart
    fi
    unset bc_lamp_autostart

    # Elasticsearch Customization - Autostart
    if [ $bc_elasticsearch_flag -eq 1 ] && [ $bc_elasticsearch_autostart -eq 1 ]; then
        includeCustomization elasticsearch_autostart
    fi
fi

# Magento Customization - Variables and Alias
if [ $bc_elasticsearch_flag -eq 1 ] && [ $bc_magento -eq 1 ]; then
    includeCustomization magento
else
    # LAMP Customization - Variables and Alias
    bc_lamp=$(checkCustomization lamp)
    if [ $bc_lamp -eq 1 ]; then
        includeCustomization lamp
    else
        # Apache Customization - Variables and Alias
        bc_apache=$(checkCustomization apache)
        if [ $bc_apache -eq 1 ]; then
            includeCustomization apache
        fi
        unset bc_apache

        # MySQL Customization - Variables and Alias
        bc_mysql=$(checkCustomization mysql)
        if [ $bc_mysql -eq 1 ]; then
            includeCustomization mysql
        fi
        unset bc_mysql
    fi
    unset bc_lamp

    # Elasticsearch Customization - Variables and Alias
    if [ $bc_elasticsearch_flag -eq 1 ] && [ $bc_elasticsearch -eq 1 ]; then
        includeCustomization elasticsearch
    fi
fi

# Clean elasticsearch dependent customizations
unset bc_elasticsearch bc_elasticsearch_autostart bc_magento bc_magento_autostart bc_elasticsearch_flag bc_elasticsearch_path

# Docker Customization - Autostart
bc_docker_autostart=$(checkCustomization docker_autostart)
if [ $bc_docker_autostart -eq 1 ]; then
    includeCustomization docker_autostart
fi
unset bc_docker_autostart

# Docker Customization - Variables and Alias
bc_docker=$(checkCustomization docker)
if [ $bc_docker -eq 1 ]; then
    includeCustomization docker
fi
unset bc_docker
