#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# Assign permissions
printInfoMessage "SETTING $filperm PERMISSION TO FILES AT $path" before
sudo find "$path" -type f ! -perm "$exeperm" ! -perm "$filperm" -exec chmod -c "$filperm" {} +
