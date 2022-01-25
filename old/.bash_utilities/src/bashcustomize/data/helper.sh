#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

function printHelp() {
  printMessage "BASHCUSTOMIZE COMMANDS HELP"
  printMessage "  bashcustomize help\n\tPrint this message"
  printMessage "  bashcustomize list\n\tPrints defined variables"
  printMessage "  bashcustomize set [name] [value]\n\tSet a customization variable, if no [value] provided is set to blank"
  printMessage "  bashcustomize unset [name]\n\tUnset (delete) a customization variable"
  printMessage "  bashcustomize reset\n\tSet default values on variables" 1
}

function dispatchErrorMessage() {
  # $1 Error message
  error_info="Type 'bashcustomize help' to find out how it works"
  if [ -z "$1" ]; then
    printErrorMessage "$error_info"
  else
    printErrorMessage "$1. $error_info"
  fi
}

function dispatchResetNeedMessage() {
  # $1 Information message
  need_reset_info="You must restart to apply changes"
  if [ -z "$1" ]; then
    printInfoMessage "$need_reset_info" 1
  else
    printInfoMessage "$1. $need_reset_info" 1
  fi
}
