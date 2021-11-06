#!/bin/bash

# Bash Utilities Bin Folder
if [ -d ~/.bash_utilities/bin ]; then
  PATH="$PATH:~/.bash_utilities/bin"
  export PATH
fi

# BASH CUSTOMIZE
## Variables initialization
if [ ! -f ~/.bash_utilities/src/bashcustomize/vars.ini ]; then
  bashcustomize init
fi
source ~/.bash_utilities/src/bashcustomize/vars.ini
source ~/.bash_utilities/src/bashcustomize/data/manager.sh

# GIT Customization
if [ $(checkCustomization gitflow) -eq 1 ]; then
  includeCustomization gitflow
fi

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

clear
