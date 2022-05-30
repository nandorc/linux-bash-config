#!/bin/bash

# Load dependencies
source ~/.basher/lib/colorhandler.sh

# Get command name
command_name=$1

# Show default help
[ -z "$command_name" ] && basher mdv ~/.basher/src/help/README.md && exit

# Check if is a valid component or command
[ ! -d ~/.basher/src/"$command_name" ] && echo -e "\n$(color red)Execution Exception: $(color yellow)$command_name$(color) is not a valid command or component\nType $(color yellow)basher help:list$(color) to get a list of available commands and components\n" && exit 1

# Check if README file exists
[ ! -f ~/.basher/src/"$command_name"/README.md ] && echo -e "\n$(color red)Execution Exception: $(color yellow)$command_name$(color) doesn't have documentation\n" && exit 1

# Show help for specific command
basher mdv ~/.basher/src/"$command_name"/README.md
