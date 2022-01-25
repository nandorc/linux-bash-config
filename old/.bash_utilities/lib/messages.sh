#!/bin/bash

function printMessage() {
  # $1 message
  # $2 spacing. none empty or invalid
  #   'none'    No before or after empty line
  #   'before'  Before empty line only
  #   'after'   After empty line only
  #   'both'    Before and after empty lines
  if [ "$2" = "both" ]; then
    echo -e "\n$1\n"
  elif [ "$2" = "after" ]; then
    echo -e "$1\n"
  elif [ "$2" = "before" ]; then
    echo -e "\n$1"
  else
    echo -e "$1"
  fi
}

function printErrorMessage() {
  # $1 error message
  # $2 spacing. @see printMessage
  if [ -z "$1" ]; then
    printMessage "\033[31mERROR\033[0m" "$2"
  else
    printMessage "\033[31mERROR: \033[0m$1" "$2"
  fi
  exit 1
}

function printInfoMessage() {
  # $1 information message
  # $2 spacing. @see printMessage
  if [ ! -z "$1" ]; then
    printMessage "\033[34mINFO: \033[0m$1" "$2"
  fi
}

function printWarningMessage() {
  # $1 information message
  # $2 spacing. @see printMessage
  if [ ! -z "$1" ]; then
    printMessage "\033[33mWARNING: \033[0m$1" "$2"
  fi
}
