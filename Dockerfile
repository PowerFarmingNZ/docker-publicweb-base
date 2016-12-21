#TODO: Merge with apache...
FROM gavinjonespf/apache-php:latest
MAINTAINER Gavin Jones <gjones@powerfarming.co.nz>

ENV         ALLOW_OVERRIDE true
ENV         TERM xterm

#Build args
ARG         COMMIT_ID=unknown
ARG         GIT_COMMIT=unknown
ARG         GIT_BRANCH=unknown
ARG         BUILD_NUMBER=experimental
ARG         GIT_URL=unknown
ARG         BUILD_DATE=$BUILD_NUMBER
ARG         IMAGE_NAME="docker-publicweb-base"
ARG         IMAGE_DESC="Template for all public websites"
ARG         IMAGE_URL=$GIT_URL

#Apache defaults for publicweb
RUN         a2enmod rewrite
RUN         a2enmod expires
RUN         a2enmod headers
RUN         a2enmod include
RUN         a2enmod cache
RUN         a2enmod cache_disk
RUN         a2enmod authz_groupfile
RUN         a2enmod cgi
RUN         a2enmod ssl
RUN         a2enmod suexec
RUN         a2enmod vhost_alias

RUN         rm -fr /app

#Add default uploads size update
RUN         mkdir -p /usr/local/etc/php/conf.d/
COPY        files/upload.ini /etc/php5/mods-available/pfuploads.ini
RUN         ln -s /etc/php5/mods-available/pfuploads.ini /etc/php5/apache2/conf.d/99-pfuploads.ini

#Add default session config
COPY        files/session.ini /etc/php5/mods-available/pfsession.ini
RUN         ln -s /etc/php5/mods-available/pfsession.ini /etc/php5/apache2/conf.d/99-pfsession.ini

#Add scripts
RUN         mkdir -p /scripts/init.d/
COPY        init.d/ /scripts/init.d/
RUN         chmod -R a+rx /scripts/init.d/*.sh 
COPY        scripts/ /scripts/
RUN         chmod -R a+rx /scripts/*.sh 

HEALTHCHECK CMD /scripts/healthcheck.sh 

#Redirector
RUN         mkdir -p /app/site/redirector && chown -R www-data:www-data /app/site/redirector
#Add custom stuff?
COPY        templateredirector.conf  /etc/apache2/sites-available/zzz-default.conf
COPY        index.php  /app/site/redirector/

#Cache and session
RUN         mkdir -p /app/site/cache/ && mkdir -p /app/site/session/ && chown www-data:www-data /app/site/cache  && chown www-data:www-data /app/site/session

ARG         COMMIT_ID
RUN         echo $COMMIT_ID >> commitid.txt
EXPOSE      80

# Basic build-time metadata as defined at http://label-schema.org
LABEL       org.label-schema.schema-version="1.0.0-rc.1" \
            org.label-schema.build-date="${BUILD_DATE}" \
            org.label-schema.license="Copyright" \
            org.label-schema.name="${IMAGE_DESC}" \
            org.label-schema.url="${IMAGE_URL}" \
            org.label-schema.vendor="Power Farming" \
            org.label-schema.version="${BUILD_VERSION}" \
            org.label-schema.vcs-ref="${GIT_COMMIT}" \
            org.label-schema.vcs-url="${GIT_URL}" \
            org.label-schema.vcs-type="Git"
            