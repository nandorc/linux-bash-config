#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

vars[0]="gitflow=on"
vars[1]="wsl=off"
vars[2]="apache=off"
vars[3]="apache_autostart=off"
vars[4]="mysql=off"
vars[5]="mysql_autostart=off"
vars[6]="lamp=off"
vars[7]="lamp_autostart=off"
vars[8]="elasticsearch=off"
vars[9]="elasticsearch_=ath"
vars[10]="elasticsearch_autostart=off"
vars[11]="magento=off"
vars[12]="magento_autostart=off"
vars[13]="docker=off"
vars[14]="docker_autostart=off"

# Remove vars.ini file if exists
if [ -f ~/.bash_utilities/src/bashcustomizer/etc/vars.ini ]; then
    rm ~/.bash_utilities/src/bashcustomizer/etc/vars.ini
fi

# Save default values on variables
for i in "${vars[@]}"; do
    arr=(${i//=/ })
    ~/.bash_utilities/src/bashcustomizer/cmd/manage.sh -q set "${arr[0]}" "${arr[1]}"
done

# Print end message if required
if [ "$1" != "-q" ]; then
    printInfoMessage "Variables were set to default values." before
    printMessage "You must restart to apply changes." after
fi
unset vars i arr
