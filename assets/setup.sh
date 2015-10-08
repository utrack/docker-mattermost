#!/bin/bash

# add Mattermost user
useradd -m -d ${APP_HOME} --disabled-login --gecos 'Mattermost' mattermost
passwd -d mattermost

cd ${APP_HOME}

sudo -HEu mattermost wget -qO- https://github.com/mattermost/platform/releases/download/v${APP_VER}/mattermost.tar.gz | tar xvz -C ${APP_HOME}

# create data dir
mkdir /data
chown -R mattermost /data

#move configs
mkdir /config
mv ${APP_HOME}/mattermost/config/config.json /config/config.json
chmod 644 /config/config.json

sudo -HEu mattermost ln -s /config/config.json ${APP_HOME}/mattermost/config/config.json

# change docker dirs and ports
sed "s/:8065/:80/" -i /config/config.json
sed "s/.\/data/\/data/" -i /config/config.json

cat << EOF > /etc/init/mattermost.conf
start on runlevel [2345]
stop on runlevel [016]
respawn
chdir ${APP_HOME}
setuid mattermost
exec bin/platform
EOF
