#!/bin/bash

# Start LAMP services
function startLampServices() {
    sudo service apache2 start
    sudo service mysql start
}

# Stop LAMP services
function stopLampServices() {
    sudo service apache2 stop
    sudo service mysql stop
}

# Restart LAMP services
function restartLampServices() {
    sudo service apache2 restart
    sudo service mysql restart
}
