#!/bin/bash

# add Mattermost user
adduser --home ${APP_HOME} --disabled-login --gecos 'Mattermost' mattermost
passwd -d mattermost

cd ${APP_HOME}

sudo -HEu mattermost curl -L https://github.com/mattermost/platform/releases/download/v${APP_VER}/mattermost.tar.gz | tar xvz -C ${APP_HOME}

# create data dir
mkdir /data
chown -R mattermost /data

# create log dir
mkdir ${APP_HOME}/mattermost/logs
chown -R mattermost ${APP_HOME}/mattermost/logs

#move configs
mkdir /config
mv ${APP_HOME}/mattermost/config/config.json /config/config.json
chmod 644 /config/config.json

# change docker dirs and ports
sed "s/:8065/:80/" -i /config/config.json
sed "s/.\/data/\/data/" -i /config/config.json

chmod +x /assets/start.sh
