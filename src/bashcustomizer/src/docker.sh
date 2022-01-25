#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# Docker Service
alias docker_start="printInfoMessage 'Starting docker service.' before && sudo service docker start && printInfoMessage 'Docker service started.' after"
alias docker_stop="printInfoMessage 'Stopping docker service.' before && sudo service docker stop && printInfoMessage 'Docker service stopped.' after"
alias docker_restart="printInfoMessage 'Restarting docker service.' before && sudo service docker restart && printInfoMessage 'Docker service restarted.' after"
