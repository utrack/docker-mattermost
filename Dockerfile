FROM sameersbn/ubuntu:14.04.20150825
MAINTAINER u@colonpipe.biz

ENV APP_VER=1.0.0
ENV DB_DRIVER=postgres
ENV DB_URI="postgres://mattermost:changeme@postgres/mattermost?sslmode=disable"
ENV APP_HOME="/home/mattermost"

ENV TEAM_NAME=Mattermost

EXPOSE 80

COPY assets /assets
RUN bash /assets/install.sh

EXPOSE 80:tcp

VOLUME ["/data","/config"]
WORKDIR /assets
ENTRYPOINT["/assets/start.sh"]
