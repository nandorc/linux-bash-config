#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Apache
alias bc:apache:start="wrapCommand --colored 'Starting apache service...' 'sudo service apache2 start' both"
alias bc:apache:stop="wrapCommand --colored 'Stopping apache service...' 'sudo service apache2 stop' both"
alias bc:apache:restart="wrapCommand --colored 'Restarting apache service...' 'sudo service apache2 restart' both"
# Localhost
alias bc:localhost="explorer.exe http://localhost"
