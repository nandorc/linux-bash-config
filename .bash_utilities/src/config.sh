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

# GIT Customization
if [ -n "$custom_bash_gitflow" ] && [ "$custom_bash_gitflow" == "on" ] && [ -f ~/.bash_utilities/src/bashcustomize/customs/gitflow.sh ]; then
  . ~/.bash_utilities/src/bashcustomize/customs/gitflow.sh
fi

# Apache Customization - Autostart
if [ -n "$custom_bash_apache_autostart" ] && [ "$custom_bash_apache_autostart" == "on" ] && [ -f ~/.bash_utilities/src/bashcustomize/customs/apache_autostart.sh ]; then
  . ~/.bash_utilities/src/bashcustomize/customs/apache_autostart.sh
fi

# Apache Customization - Variables and Alias
if [ -n "$custom_bash_apache" ] && [ "$custom_bash_apache" == "on" ] && [ -f ~/.bash_utilities/src/bashcustomize/customs/apache.sh ]; then
  . ~/.bash_utilities/src/bashcustomize/customs/apache.sh
fi

clear
