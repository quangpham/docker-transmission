#FROM ubuntu
FROM debian:wheezy
MAINTAINER Quang Pham  "me@quangpham.com"

# Add ngix source
RUN echo "deb http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-key adv --fetch-keys "http://nginx.org/keys/nginx_signing.key"
RUN apt-get update
RUN apt-get dist-upgrade -y -q
RUN apt-get install -y -q transmission-daemon
RUN apt-get install -y -q nginx
RUN apt-get install -y -q supervisor
#RUN apt-get install -y -q calibre
RUN apt-get install -y -q python3 python3-dev python3-pip python3-pyqt4 libtiff4-dev libpng12-dev libjpeg8-dev p7zip-full
RUN apt-get clean

# Config Transmission
ADD transmission/settings.json /etc/transmission-daemon/settings.json
ADD transmission/foreground.sh /etc/transmission-daemon/foreground.sh
RUN chmod 755 /etc/transmission-daemon/foreground.sh

# Config Nginx
RUN rm -rf /etc/nginx/conf.d/*
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# Config supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add Start server
ADD start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME ["/etc/transmission-daemon", "/var/lib/transmission-daemon/downloads"]
VOLUME ["/etc/nginx"]

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp
EXPOSE 80

CMD ["/bin/bash", "-e", "/start.sh"]
