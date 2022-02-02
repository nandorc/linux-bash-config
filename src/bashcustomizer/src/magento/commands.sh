#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/src/elasticsearch/commands.sh

# Start magento services
function startMagentoServices() {
    sudo service apache2 start
    sudo service mysql start
    startElasticsearchService
}

# Stop magento services
function stopMagentoServices() {
    sudo service apache2 stop
    sudo service mysql stop
    stopElasticSearchService
}

# Restart magento services
function restartMagentoServices() {
    sudo service apache2 restart
    sudo service mysql restart
    restartElasticSearchService
}
