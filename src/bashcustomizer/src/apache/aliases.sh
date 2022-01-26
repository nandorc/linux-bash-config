#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# Apache
alias apache:start="wrapCommand --colored 'Starting apache service...' 'sudo service apache2 start' both"
alias apache:stop="wrapCommand --colored 'Stopping apache service...' 'sudo service apache2 stop' both"
alias apache:restart="wrapCommand --colored 'Restarting apache service...' 'sudo service apache2 restart' both"
# Localhost
alias localhost="explorer.exe http://localhost"
