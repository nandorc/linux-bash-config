#!/bin/bash

# Bash Utilities Bin Folder
PATH="$PATH:~/.bash_utilities/bin"

# BASH CUSTOMIZE
## Variables initialization
if [ ! -f ~/.bash_utilities/src/bashcustomize/vars.ini ]; then
  bashcustomize init
fi
source ~/.bash_utilities/src/bashcustomize/vars.ini
source ~/.bash_utilities/src/bashcustomize/data/manager.sh
source ~/.bash_utilities/lib/messages.sh

# GIT Customization
if [ $(checkCustomization gitflow) -eq 1 ]; then
  includeCustomization gitflow
fi

# WSL Customization
if [ $(checkCustomization wsl) -eq 1 ]; then
  includeCustomization wsl
fi

# Elasticsearch Customization - Flag
custom_bash_elasticsearch_flag=0
if [ -n "$custom_bash_elasticsearch_path" ]; then
  if [ -d "$custom_bash_elasticsearch_path"/bin ]; then
    if [[ ! "$PATH" =~ "$custom_bash_elasticsearch_path" ]]; then
      PATH="$PATH:$custom_bash_elasticsearch_path/bin"
    fi
    custom_bash_elasticsearch_flag=1
  else
    printWarningMessage "No existing /bin folder inside elasticsearch_path. Skipping 'elasticsearch', 'elasticsearch_autostart', 'magento' and 'magento_autostart' customizations due to no /bin folder found." 1 && sleep 5
  fi
elif [ $(checkCustomization elasticsearch) -eq 1 ] || [ $(checkCustomization elasticsearch_autostart) -eq 1 ] || [ $(checkCustomization magento) -eq 1 ] || [ $(checkCustomization magento_autostart) -eq 1 ]; then
  printWarningMessage "No elasticsearch path defined. Use 'bashcustomize set custom_bash_elasticsearch_path path' to define it. Skipping 'elasticsearch', 'elasticsearch_autostart', 'magento' and 'magento_autostart' customizations due to no path defined." 1 && sleep 5
fi

# Magento Customization - Autostart
if [ $custom_bash_elasticsearch_flag -eq 1 ] && [ $(checkCustomization magento_autostart) -eq 1 ]; then
  includeCustomization magento_autostart
else
  # LAMP Customization - Autostart
  if [ $(checkCustomization lamp_autostart) -eq 1 ]; then
    includeCustomization lamp_autostart
  else
    # Apache Customization - Autostart
    if [ $(checkCustomization apache_autostart) -eq 1 ]; then
      includeCustomization apache_autostart
    fi
    # MySQL Customization - Autostart
    if [ $(checkCustomization mysql_autostart) -eq 1 ]; then
      includeCustomization mysql_autostart
    fi
  fi
  # Elasticsearch Customization - Autostart
  if [ $custom_bash_elasticsearch_flag -eq 1 ] && [ $(checkCustomization elasticsearch_autostart) -eq 1 ]; then
    includeCustomization elasticsearch_autostart
  fi
fi

# Magento Customization - Variables and Alias
if [ $custom_bash_elasticsearch_flag -eq 1 ] && [ $(checkCustomization magento) -eq 1 ]; then
  includeCustomization magento
else
  # LAMP Customization - Variables and Alias
  if [ $(checkCustomization lamp) -eq 1 ]; then
    includeCustomization lamp
  else
    # Apache Customization - Variables and Alias
    if [ $(checkCustomization apache) -eq 1 ]; then
      includeCustomization apache
    fi
    # MySQL Customization - Variables and Alias
    if [ $(checkCustomization mysql) -eq 1 ]; then
      includeCustomization mysql
    fi
  fi
  # Elasticsearch Customization - Variables and Alias
  if [ $custom_bash_elasticsearch_flag -eq 1 ] && [ $(checkCustomization elasticsearch) -eq 1 ]; then
    includeCustomization elasticsearch
  fi
fi

# Docker Customization - Autostart
if [ $(checkCustomization docker_autostart) -eq 1 ]; then
  includeCustomization docker_autostart
fi

# Docker Customization - Variables and Alias
if [ $(checkCustomization docker) -eq 1 ]; then
  includeCustomization docker
fi

export PATH
clear
