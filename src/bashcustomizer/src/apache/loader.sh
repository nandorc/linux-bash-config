#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

wrapFileInclusion "Including apache variables" "~/.bash_utilities/src/bashcustomizer/src/apache/variables.sh"

# # Localhost
# localhost_path="$webserver_path/html"
# localhost_url="http://localhost"
# alias localhost="explorer.exe $localhost_url"
# alias localhost_path="cd $localhost_path"
