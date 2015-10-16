#!/bin/bash


echo "Starting up..."
perl -0777 -i.original -pe 's/"SqlSettings": \{\n\s*"DriverName": "\K[^"]*/$ENV{DB_DRIVER}/igs' /config/config.json
perl -0777 -i.original -pe 's/"DataSource": "\K[^"]*/$ENV{DB_URI}/igs' /config/config.json
perl -0777 -i.original -pe 's/"FileLocation": "\K[^"]*/$ENV{APP_HOME}\/mattermost\/logs\/production.log/igs' /config/config.json
perl -0777 -i.original -pe 's/:80/:8080/igs' /config/config.json
echo "Regexes ran OK"
cd ${APP_HOME}/mattermost/bin
sudo -HEu mattermost ${APP_HOME}/mattermost/bin/platform -config /config/config.json
