#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/src/boot/lib/featureshandler.sh

# Check features.ini file
if [ ! -f ~/.basher/src/boot/var/features.ini ]; then
    printWarningMessage " * features.ini not set"
    basher boot:reset --no-color --spacing none --no-restart
fi

configFeatures=$(cat ~/.basher/src/boot/var/features.ini)
if [ -n "$configFeatures" ]; then
    # BEGIN
    printMessage "<ServicesInitialization>"

    # Dispatch initializations
    homeDir=~/.basher/src/
    featuresArray=(${configFeatures// / })
    for i in "${featuresArray[@]}"; do
        feature=(${i//=/ }) && featureName=${feature[0]} && featureStatus=${feature[1]}
        if [ $(isFeature $featureName) -eq 1 ] && [ "$(getINIVar ~/.basher/src/boot/var/features.ini $featureName)" = "on" ]; then
            mustBeLoaded=1
            featureParents=$(getINIVar ~/.basher/src/"$featureName"/etc/feature-conf.ini parents)
            if [ -n "$featureParents" ]; then
                featureParentsArray=(${featureParents//,/ })
                for j in "${featureParentsArray[@]}"; do
                    [ $(isFeature $j) -eq 1 ] && [ "$(getINIVar ~/.basher/src/boot/var/features.ini $j)" = "on" ] && echo " - $featureName verification skipped due to $j parent active" && mustBeLoaded=0 && break
                done
                unset featureParentsArray j
            fi
            if [ $mustBeLoaded -eq 1 ]; then
                featureType=$(getINIVar ~/.basher/src/"$featureName"/etc/feature-conf.ini type)
                [ "$featureType" = "simple" ] && printMessage "Checking $featureName service status..."
                [ "$featureType" = "compound" ] && printMessage "Checking $featureName services status..."
                if [ $(basher $featureName:status --output bool) -eq 1 ]; then
                    [ "$featureType" = "simple" ] && printMessage " * $featureName is currently running"
                    [ "$featureType" = "compound" ] && printMessage " * all $featureName services are currently running"
                else
                    [ "$featureType" = "simple" ] && printMessage " * $featureName is not running"
                    [ "$featureType" = "compound" ] && printMessage " * at least one of $featureName services is not running"
                    basher $featureName:start --no-color --spacing none
                fi
                unset featureType
            fi
            unset mustBeLoaded featureParents
        fi
        unset feature featureName featureStatus
    done
    unset featuresArray homeDir i

    # END
    printMessage "</ServicesInitialization>"
fi
unset configFeatures
