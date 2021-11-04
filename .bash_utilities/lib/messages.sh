#!/bin/bash

function printMessage() {
  # $1 message
  # $2 isLast - 0/1 - 0 on default, empty or invalid
  if [ "$2" = "1" ]; then
    echo -e "\n$1\n"
  else
    echo -e "\n$1"
  fi
}

function printErrorMessage() {
  # $1 error message
  if [ -z "$1" ]; then
    printMessage "\033[31mERROR\033[0m" 1
  else
    printMessage "\033[31mERROR: \033[0m$1" 1
  fi
  exit 1
}

function printInfoMessage() {
  # $1 information message
  # $2 isLast - 0/1 - 0 on default, empty or invalid
  if [ ! -z "$1" ]; then
    printMessage "\033[34mINFO: \033[0m$1" "$2"
  fi
}

function printWarningMessage() {
  # $1 information message
  # $2 isLast - 0/1 - 0 on default, empty or invalid
  if [ ! -z "$1" ]; then
    printMessage "\033[33mWARNING: \033[0m$1" "$2"
  fi
}
