#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Assign permissions
printInfoMessage "SETTING $exeperm PERMISSION TO EXECUTABLE FILES AT $path" before
## Files without extension
sudo find "$path" -type f ! -name "*.*" ! -perm "$exeperm" -exec chmod -c "$exeperm" {} +
## .sh files
sudo find "$path" -type f -name "*.sh" ! -perm "$exeperm" -exec chmod -c "$exeperm" {} +
