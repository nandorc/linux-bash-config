#!/bin/bash

# Dispatch initializations
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commandsArray=(${commands// / })
homeDir=~/.basher/src/
for i in "${commandsArray[@]}"; do
    command=$(echo $i | sed -e "s|$homeDir||g")
    if [ -f "$i"/etc/variables.sh ]; then
        . "$i"/etc/variables.sh
        printMessage " * $command variables included"
    fi
    if [ -f "$i"/etc/aliases.sh ]; then
        . "$i"/etc/aliases.sh
        printMessage " * $command aliases included"
    fi
    if [ -f "$i"/etc/style.sh ]; then
        . "$i"/etc/style.sh
        printMessage " * $command style included"
    fi
    if [ -f "$i"/etc/settings.sh ]; then
        . "$i"/etc/settings.sh
        printMessage " * $command settings included"
    fi
done
unset commands commandsArray homeDir i command
