#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh

# BEGIN
printInfoMessage "Available basher commands and components" before
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commandsArray=(${commands// / })
homeDir=~/.basher/src/
for i in "${commandsArray[@]}"; do
    command=$(echo $i | sed -e "s|$homeDir||g")
    message="$command\t"
    [ ${#command} -lt 8 ] && message="$message\t"
    printMessage "$message:\tFor complete reference type 'basher help $command'"
done
echo ""
unset commands commandsArray homeDir i command message
