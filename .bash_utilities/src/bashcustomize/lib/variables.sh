#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/helper.sh
source ~/.bash_utilities/lib/messages.sh

function manageVariable() {
  # $action set/unset
  # $var variable name
  # $val variable value
  # $quiet 0/1
  if [ "$1" == "-q" ]; then
    quiet=1 && action="$2" && var="$3" && val="$4"
  else
    quiet=0 && action="$1" && var="$2" && val="$3"
  fi
  if [ "$action" != "set" ] && [ "$action" != "unset" ]; then
    dispatchErrorMessage "No valid action to manage variables"
  elif [ -z "$var" ]; then
    dispatchErrorMessage "No variable name provided"
  elif [ ! -f ~/.bash_utilities/src/bashcustomize/vars.ini ]; then
    touch ~/.bash_utilities/src/bashcustomize/vars.ini
    if [ $quiet -eq 0 ]; then
      printWarningMessage "No file holding any variable found. File will be created." && manageVariable "$action" "$var" "$val"
    else
      manageVariable -q "$action" "$var" "$val"
    fi
  elif [ -z $(cat ~/.bash_utilities/src/bashcustomize/vars.ini | grep "^custom_bash_$var=") ]; then
    if [ "$action" = "set" ]; then
      echo "custom_bash_$var=$val" >>~/.bash_utilities/src/bashcustomize/vars.ini
      if [ $quiet -eq 0 ]; then
        if [ -z "$val" ]; then
          dispatchResetNeedMessage "'$var' setted to empty value"
        else
          dispatchResetNeedMessage "'$var' setted with value '$val'"
        fi
      fi
    else
      if [ $quiet -eq 0 ]; then
        printInfoMessage "'$var' is not a defined variable" 1
      fi
    fi
  else
    if [ "$action" = "set" ]; then
      sed -i "s/custom_bash_$var=\(.*\)/custom_bash_$var=$val/g" ~/.bash_utilities/src/bashcustomize/vars.ini
      if [ $quiet -eq 0 ]; then
        if [ -z "$val" ]; then
          dispatchResetNeedMessage "'$var' updated to empty value"
        else
          dispatchResetNeedMessage "'$var' updated. New value is '$val'"
        fi
      fi
    else
      sed -i "/^custom_bash_$var=/d" ~/.bash_utilities/src/bashcustomize/vars.ini
      if [ $quiet -eq 0 ]; then
        dispatchResetNeedMessage "'$var' was deleted"
      fi
    fi
  fi
}
