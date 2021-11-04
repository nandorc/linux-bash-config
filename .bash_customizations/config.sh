#!/bin/bash

# Bash Customization Bin Folder
if [ -d ~/.bash_customizations/bin ]; then
  PATH="$PATH:~/.bash_customizations/bin"
  export PATH
fi

# Variables initialization
if [ ! -f ~/.bash_customizations/vars.ini ]; then
  bashcustomize init
fi
source ~/.bash_customizations/vars.ini

# GIT Customization
if [ -n "$custom_bash_gitflow" ] && [ "$custom_bash_gitflow" == "on" ] && [ -f ~/.bash_customizations/customs/gitflow.sh ]; then
  . ~/.bash_customizations/customs/gitflow.sh
fi

# Apache Customization - Autostart
if [ -n "$custom_bash_apache_autostart" ] && [ "$custom_bash_apache_autostart" == "on" ] && [ -f ~/.bash_customizations/customs/apache_autostart.sh ]; then
  . ~/.bash_customizations/customs/apache_autostart.sh
fi

# Apache Customization - Variables and Alias
if [ -n "$custom_bash_apache" ] && [ "$custom_bash_apache" == "on" ] && [ -f ~/.bash_customizations/customs/apache.sh ]; then
  . ~/.bash_customizations/customs/apache.sh
fi

clear
