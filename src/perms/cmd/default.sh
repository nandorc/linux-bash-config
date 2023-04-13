#!/bin/bash

# Load dependencies
source ~/.basher/lib/flaghandler.sh
source ~/.basher/lib/messagehandler.sh

# Define variables
declare options use_defaults owner_name group_name filperm dirperm exeperm selected_paths selected_path
options=$*
use_defaults=$(hasFlag --defaults ${options}) && options=$(pruneFlag --defaults ${options})
owner_name=$(getFlagValue --owner ${options}) && options=$(pruneFlagValue --owner ${options})
group_name=$(getFlagValue --group ${options}) && options=$(pruneFlagValue --group ${options})
filperm=$(getFlagValue --file ${options}) && options=$(pruneFlagValue --file ${options})
dirperm=$(getFlagValue --folder ${options}) && options=$(pruneFlagValue --folder ${options})
exeperm=$(getFlagValue --exe ${options}) && options=$(pruneFlagValue --exe ${options})
selected_paths=(${options})

# Check selected paths
[ ${#selected_paths[@]} -eq 0 ] && genericException "No paths received to apply perms\n$(commandHelpInfoMessage perms 0 0)" 1 1
for selected_path in "${selected_paths[@]}"; do
    [ ! -d "${selected_path}" ] && [ ! -f "${selected_path}" ] && genericException "$(color cyan)${selected_path}$(color) is not a valid path to a file or folder\n$(commandHelpInfoMessage perms 0 0)" 1 1
done

# Replace values by defaults if necessary
[ ${use_defaults} -eq 1 ] && [ -z "${filperm}" ] && filperm=0664
[ ${use_defaults} -eq 1 ] && [ -z "${dirperm}" ] && dirperm=2775
[ ${use_defaults} -eq 1 ] && [ -z "${exeperm}" ] && exeperm=0775

# Apply permissions on selected paths
mayNeedSudoMessage 1 1 0
for selected_path in "${selected_paths[@]}"; do
    commandBlockHeading "BASHER PERMS EXECUTION FOR ${selected_path}" 0 0
    # set ownership
    if [ -n "${owner_name}" ]; then
        if [ -n "${group_name}" ]; then
            genericInfoMessage "Setting $(color cyan)${owner_name}$(color) as owner and $(color cyan)${group_name}$(color) as group for $(color cyan)${selected_path}$(color)" 0 0
        else
            genericInfoMessage "Setting ownership to $(color cyan)${owner_name}$(color) for $(color cyan)${selected_path}$(color)" 0 0
            groupname="${owner_name}"
        fi
        sudo chown -R -c "${owner_name}":"${group_name}" "${selected_path}"
    elif [ -n "${group_name}" ]; then
        genericInfoMessage "Setting $(color cyan)${group_name}$(color) as group for $(color cyan)${selected_path}$(color)" 0 0
        sudo chown -R -c :"${group_name}" "${selected_path}"
    fi
    # set perms to executable files
    if [ -n "${exeperm}" ]; then
        genericInfoMessage "Setting $(color cyan)${exeperm}$(color) permission to executable files at $(color cyan)${selected_path}$(color)" 0 0
        # Files without extension
        sudo find "${selected_path}" -type f ! -name "*.*" ! -perm "${exeperm}" -exec chmod -c "${exeperm}" {} +
        # .sh files
        sudo find "${selected_path}" -type f -name "*.sh" ! -perm "${exeperm}" -exec chmod -c "${exeperm}" {} +
    fi
    # set perms to regular files
    if [ -n "${filperm}" ]; then
        genericInfoMessage "Setting $(color cyan)${filperm}$(color) permission to files at $(color cyan)${selected_path}$(color)" 0 0
        sudo find "${selected_path}" -type f ! -perm "-u=x" ! -perm "${filperm}" -exec chmod -c "${filperm}" {} +
    fi
    # set perms to folders
    if [ -n "${dirperm}" ]; then
        genericInfoMessage "Setting $(color cyan)${dirperm}$(color) permission to folders at $(color cyan)${selected_path}$(color)" 0 0
        sudo find "${selected_path}" -type d ! -perm "${dirperm}" -exec chmod -c "${dirperm}" {} +
    fi
    echo ""
done
