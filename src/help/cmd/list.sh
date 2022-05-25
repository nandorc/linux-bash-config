#!/bin/bash

# Load dependencies
source ~/.basher/etc/colors.sh

# Show title
echo -e "\n"$color_blue"Available "$color_yellow"basher"$color_blue" commands and components"$color_none"\n"
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commands_array=(${commands// / })
homeDir=~/.basher/src/
for i in "${commands_array[@]}"; do
    command=$(echo $i | sed -e "s|$homeDir||g")
    message="$command\t"
    [ ${#command} -lt 8 ] && message="$message\t"
    message="$message:\t"
    [ -d ~/.basher/src/"$command"/cmd ] && message="$message[CMD] "
    echo -e $message"For complete reference type "$color_yellow"basher help $command"$color_none
done
echo ""
