#!/bin/bash

source ~/.bash_customizations/data/helper.sh
source ~/.bash_customizations/utils/messages.sh

function setDefaultValues() {
  echo "custom_bash_gitflow=on" >~/.bash_customizations/vars.ini
  echo "custom_bash_apache=off" >>~/.bash_customizations/vars.ini
  echo "custom_bash_apache_autostart=off" >>~/.bash_customizations/vars.ini
}

function manageVariable() {
  # $1 action
  # $2 variable name
  # $3 variable value
  if [ "$1" != "set" ] && [ "$1" != "unset" ]; then
    dispatchErrorMessage "No valid action to manage variables"
  elif [ -z "$2" ]; then
    dispatchErrorMessage "No variable name provided"
  elif [ -z $(cat ~/.bash_customizations/vars.ini | grep "^$2=") ]; then
    if [ "$1" = "set" ]; then
      echo "$2=$3" >>~/.bash_customizations/vars.ini
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
      sed -i "s/$2=\(.*\)/$2=$3/g" ~/.bash_customizations/vars.ini
      if [ -z "$3" ]; then
        dispatchResetNeedMessage "'$2' updated to empty value"
      else
        dispatchResetNeedMessage "'$2' updated. New value is '$3'"
      fi
    else
      sed -i "/^$2=/d" ~/.bash_customizations/vars.ini
      dispatchResetNeedMessage "'$2' was deleted"
    fi
  fi
}

function listVariables() {
  printMessage "DEFINED VARIABLES" 1
  cat ~/.bash_customizations/vars.ini
  echo ""
}
