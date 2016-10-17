FROM gavinjonespf/apache-php:latest
ENV ALLOW_OVERRIDE true

#Apache defaults for publicweb
RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers
RUN a2enmod include
RUN a2enmod cache
RUN a2enmod cache_disk
RUN a2enmod authz_groupfile
RUN a2enmod cgi
RUN a2enmod ssl
RUN a2enmod suexec
RUN a2enmod vhost_alias

#RUN apt-get update && apt-get install -yq git nano && rm -rf /var/lib/apt/lists/*
RUN rm -fr /app
# ENV TERM xterm

ARG         COMMIT_ID
RUN         echo $COMMIT_ID >> commitid.txt
#ADD . /app
#RUN composer install
EXPOSE      80

# sudo docker images
