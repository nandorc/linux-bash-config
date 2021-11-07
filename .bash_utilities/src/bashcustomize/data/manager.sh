#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/helper.sh
source ~/.bash_utilities/lib/messages.sh

function setDefaultValues() {
  echo "custom_bash_gitflow=on" >~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_apache=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_apache_autostart=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_mysql=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_mysql_autostart=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_lamp=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_lamp_autostart=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_elasticsearch=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_elasticsearch_path=" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_elasticsearch_autostart=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_magento=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
  echo "custom_bash_magento_autostart=off" >>~/.bash_utilities/src/bashcustomize/vars.ini
}

function manageVariable() {
  # $1 action
  # $2 variable name
  # $3 variable value
  if [ "$1" != "set" ] && [ "$1" != "unset" ]; then
    dispatchErrorMessage "No valid action to manage variables"
  elif [ -z "$2" ]; then
    dispatchErrorMessage "No variable name provided"
  elif [ -z $(cat ~/.bash_utilities/src/bashcustomize/vars.ini | grep "^$2=") ]; then
    if [ "$1" = "set" ]; then
      echo "$2=$3" >>~/.bash_utilities/src/bashcustomize/vars.ini
      if [ -z "$3" ]; then
        dispatchResetNeedMessage "'$2' setted to empty value"
      else
        dispatchResetNeedMessage "'$2' setted with value '$3'"
      fi
    else
      printInfoMessage "'$2' is not a defined variable" 1
    fi
  else
    if [ "$1" = "set" ]; then
      sed -i "s/$2=\(.*\)/$2=$3/g" ~/.bash_utilities/src/bashcustomize/vars.ini
      if [ -z "$3" ]; then
        dispatchResetNeedMessage "'$2' updated to empty value"
      else
        dispatchResetNeedMessage "'$2' updated. New value is '$3'"
      fi
    else
      sed -i "/^$2=/d" ~/.bash_utilities/src/bashcustomize/vars.ini
      dispatchResetNeedMessage "'$2' was deleted"
    fi
  fi
}

function listVariables() {
  printMessage "DEFINED VARIABLES" 1
  cat ~/.bash_utilities/src/bashcustomize/vars.ini
  echo ""
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
