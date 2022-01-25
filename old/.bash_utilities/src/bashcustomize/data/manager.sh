#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/lib/variables.sh
source ~/.bash_utilities/lib/messages.sh

function setDefaultValues() {
  manageVariable -q set gitflow on
  manageVariable -q set wsl off
  manageVariable -q set apache off
  manageVariable -q set apache_autostart off
  manageVariable -q set mysql off
  manageVariable -q set mysql_autostart off
  manageVariable -q set lamp off
  manageVariable -q set lamp_autostart off
  manageVariable -q set elasticsearch off
  manageVariable -q set elasticsearch_path
  manageVariable -q set elasticsearch_autostart off
  manageVariable -q set magento off
  manageVariable -q set magento_autostart off
  manageVariable -q set docker off
  manageVariable -q set docker_autostart off
}

function checkCustomization() {
  # $1 customization variable name without prefix
  var="custom_bash_$1"
  if [ -n "${!var}" ] && [ "${!var}" == "on" ] && [ -f ~/.bash_utilities/src/bashcustomize/customs/"$1".sh ]; then
    echo 1
  else
    echo 0
  fi
}

function includeCustomization() {
  # $1 customization name
  if [ ! -z "$1" ]; then
    . ~/.bash_utilities/src/bashcustomize/customs/"$1".sh
  fi
}
