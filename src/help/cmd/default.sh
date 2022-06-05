#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh

# Get command name
declare command_name
command_name=${1}

# Show default help
[ -z "${command_name}" ] && basher mdv ~/.basher/src/help/README.md && exit

# Check if is a valid component or command
[ ! -d ~/.basher/src/"${command_name}" ] && genericException "$(color yellow)${command_name}$(color) is not a valid command or component\n$(genericInfoMessage "Type $(color yellow)basher help:list$(color) to get a list of available commands and components" 0 0)" 1 1

# Check if README file exists
[ ! -f ~/.basher/src/"${command_name}"/README.md ] && genericException "$(color yellow)${command_name}$(color) doesn't have documentation" 1 1

# Show help for specific command
basher mdv ~/.basher/src/"${command_name}"/README.md
