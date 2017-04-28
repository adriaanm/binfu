#!/bin/bash

# first argument: jenkins job for which to download 100 build logs to /tmp/$/$buildNum.log
mkdir -p "/tmp/$1"
curl -so - https://scala-webapps.epfl.ch/jenkins/job/$1/api/json | jq ".builds[].url" | perl -pe 's/^"(.*\/)(\d*)\/"$/curl -# -o \/tmp\/'$1'\/$2.log $1$2\/consoleText &\n/' > /tmp/jenkins

echo Hit enter when download madness ends...

source /tmp/jenkins

read
reset
