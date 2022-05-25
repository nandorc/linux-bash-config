#!/bin/bash

# Load dependencies
source ~/.basher/etc/colors.sh

# Get command name
command_name=$1

# Show default help
[ -z "$command_name" ] && basher mdv ~/.basher/src/help/README.md && exit

# Check if is a valid component or command
[ ! -d ~/.basher/src/"$command_name" ] && echo -e "\n"$color_red"Execution Exception: "$color_yellow"$command_name"$color_none" is not a valid command or component\nType "$color_yellow"basher help:list"$color_none" to get a list of available commands and components\n" && exit 1

# Check if README file exists
[ ! -f ~/.basher/src/"$command_name"/README.md ] && echo -e "\n"$color_red"Execution Exception: "$color_yellow"$command_name"$color_none" doesn't have documentation\n" && exit 1

# Show help for specific command
basher mdv ~/.basher/src/"$command_name"/README.md
