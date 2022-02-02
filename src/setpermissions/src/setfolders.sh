#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Assign permissions
printInfoMessage "SETTING $dirperm PERMISSION TO FOLDERS AT $path" before
sudo find "$path" -type d ! -perm "$dirperm" -exec chmod -c "$dirperm" {} +
