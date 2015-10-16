FROM ubuntu:14.04
MAINTAINER u@colonpipe.biz

ENV APP_VER=1.0.0
ENV DB_DRIVER=postgres
ENV DB_URI="postgres://mattermost:changeme@postgres/mattermost?sslmode=disable"
ENV APP_HOME="/home/mattermost"

ENV TEAM_NAME=Mattermost

EXPOSE 80

COPY assets/ /assets/
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl 
RUN bash /assets/setup.sh

EXPOSE 80/tcp

VOLUME ["/data","/config"]
#RUN chown mattermost /var/log/supervisor
CMD ["/assets/start.sh"]
