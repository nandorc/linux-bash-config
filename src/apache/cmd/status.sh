#!/bin/bash

# Load dependencies
source ~/.basher/etc/colors.sh
source ~/.basher/lib/flagger.sh

options=$*
output=


# # Check output type
# if [ $(hasFlag --output $*) -eq 1 ] && [ -n "$output" ] && [ "$output" != "string" ] && [ "$output" != "bool" ]; then
#     printErrorMessage "No valid --output value received" both
# else
#     # Set default output value if necessary
#     [ -z "$output" ] && output="string"

#     # Get boolean service status
#     boolStatus=1
#     [[ "$(service apache2 status)" =~ "is not running" ]] && boolStatus=0

#     # Check and display output
#     if [ "$output" = "bool" ]; then
#         echo $boolStatus
#     else
#         options=$(getRebuildedOptions $*)
#         printColoredMessage "Checking apache service status..." --wrap-position begin $options
#         stringStatus=" * apache service is not running"
#         [ $boolStatus -eq 1 ] && stringStatus=" * apache is running"
#         printColoredMessage "$stringStatus" --wrap-position end --no-color $options
#         unset serviceName options stringStatus
#     fi
#     unset boolStatus
# fi
# unset output
