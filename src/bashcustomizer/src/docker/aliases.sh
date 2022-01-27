#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# Docker Service
alias bc:docker:start="wrapCommand --colored 'Starting docker service...' 'sudo service docker start' both"
alias bc:docker:stop="wrapCommand --colored 'Stopping docker service...' 'sudo service docker stop' both"
alias bc:docker:restart="wrapCommand --colored 'Restarting docker service...' 'sudo service docker restart' both"
