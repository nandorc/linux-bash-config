#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# MySQL service
alias bc:mysql:start="wrapCommand --colored 'Starting mysql service...' 'sudo service mysql start' both"
alias bc:mysql:stop="wrapCommand --colored 'Stopping mysql service...' 'sudo service mysql stop' both"
alias bc:mysql:restart="wrapCommand --colored 'Restarting mysql service...' 'sudo service mysql restart' both"
