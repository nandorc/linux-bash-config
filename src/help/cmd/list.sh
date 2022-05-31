#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh

# Define variables
declare commands home_dir command fixed_command

# Show title
commandBlockHeading "AVAILABLE BASHER COMMANDS AND COMPONENTS" 1 0
commands=$(find ~/.basher/src/* -maxdepth 0 -type d)
commands=(${commands// / })
home_dir=~/.basher/src/
echo -e "$(color cyan)           name : [CMD] : reference$(color)"
for command in "${commands[@]}"; do
    command=$(echo ${command} | sed -e "s|${home_dir}||g") && fixed_command=${command}
    while [ ${#fixed_command} -lt 15 ]; do
        fixed_command=" ${fixed_command}"
    done
    echo -e "${fixed_command} :\c"
    if [ -d ~/.basher/src/"${command}"/cmd ]; then
        echo -e "$(color green)  YES  $(color)\c"
    else
        echo -e "$(color red)  NO   $(color)\c"
    fi
    echo -e ": $(color yellow)basher help ${command}$(color)"
done
echo ""
