#!/bin/bash

# Load dependencies
source ~/.basher/lib/flagger.sh
source ~/.basher/lib/messages.sh

if [ -n "$1" ]; then
    # Get flag values
    path=$*
    useDefaults=$(hasFlag --defaults $path) && path=$(pruneFlag --defaults $path)
    ownername=$(getFlagValue --owner $path) && path=$(pruneFlagValue --owner $path)
    groupname=$(getFlagValue --group $path) && path=$(pruneFlagValue --group $path)
    filperm=$(getFlagValue --file $path) && path=$(pruneFlagValue --file $path)
    dirperm=$(getFlagValue --folder $path) && path=$(pruneFlagValue --folder $path)
    exeperm=$(getFlagValue --exe $path) && path=$(pruneFlagValue --exe $path)

    # Replace values by defaults if necessary
    [ $useDefaults -eq 1 ] && [ -z "$filperm" ] && filperm=0664
    [ $useDefaults -eq 1 ] && [ -z "$dirperm" ] && dirperm=2775
    [ $useDefaults -eq 1 ] && [ -z "$exeperm" ] && exeperm=0774

    # Validate path and execute actions
    if [ -z "$path" ]; then
        printErrorMessage "A path to a file/folder must be specified to apply permissions" both
    elif [ ! -d "$path" ] && [ ! -f "$path" ]; then
        printErrorMessage "Not an existing file or folder at '$path'" both
    else
        ~/.basher/src/perms/cmd/setownership.sh "$path" "$ownername" "$groupname"
        ~/.basher/src/perms/cmd/setexefiles.sh "$path" "$exeperm"
        ~/.basher/src/perms/cmd/setregfiles.sh "$path" "$filperm"
        ~/.basher/src/perms/cmd/setfolders.sh "$path" "$dirperm"
        printInfoMessage "Permissions assignement process finished" both
    fi
    unset ownername groupname filperm dirperm exeperm path
else
    printErrorMessage "No valid parameters received for perms" before
    printWarningMessage "Type 'basher help perms' to know the to use the command" after
fi
