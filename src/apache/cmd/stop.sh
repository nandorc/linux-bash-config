#!/bin/bash

# Load dependencies
source ~/.basher/etc/colors.sh

[ $(basher apache:status --output bool) -eq 0 ] && echo -e "Detenido"

# source ~/.basher/lib/wrapper.sh

# # Format command options
# options=$(getRebuildedOptions $*)

# # Begining message
# printColoredMessage "Stoping apache service..." --wrap-position begin $options

# # Check and stop service
# if [ $(basher apache:status --output bool) -eq 0 ]; then
#     printColoredMessage " * apache service is currently stopped" --wrap-position end --no-color $options
# else
#     sudo service apache2 stop
#     printColoredMessage " * apache service stopped" --wrap-position end --no-color $options
# fi
# unset serviceName options
