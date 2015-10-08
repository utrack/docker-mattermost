#!/bin/bash


perl -0777 -i.original -pe 's/"SqlSettings": \{\n\s*"DriverName": "\K[^"]*/$ENV{DB_DRIVER}"/igs' /config/config.json
perl -0777 -i.original -pe 's/"DataSource": "\K[^"]*/$ENV{DB_URI}/igs' /config/config.json
start mattermost
