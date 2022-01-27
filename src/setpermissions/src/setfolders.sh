#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# Assign permissions
printInfoMessage "SETTING $dirperm PERMISSION TO FOLDERS AT $path" before
sudo find "$path" -type d ! -perm "$dirperm" -exec chmod -c "$dirperm" {} +
