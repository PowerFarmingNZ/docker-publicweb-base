#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/apache2/* /tmp/apache*

#Handle CNAME and default redirection
if [ -z "$APPLICATION_CNAME" ]; then
    ALTCNAME=$(echo $VIRTUAL_HOST| awk -F',' '{print $1}')
    echo "WARNING: No CNAME in env, using $ALTCNAME from VIRTUAL_HOST"
    export APPLICATION_CNAME=$ALTCNAME

    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "CNAME already in .apacheenv"
    else
        ex="export APPLICATION_CNAME=$ALTCNAME"
        echo "$ex" >> /scripts/.apacheenv
    fi
fi

#Need escaped regex
if [ -z "$APPLICATION_CNAME_REGEX" ]; then
    appregex=$(echo "$APPLICATION_CNAME" | sed 's/\./\\./g')
    export APPLICATION_CNAME_REGEX=$appregex

    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "CNAME_REGEX already in .apacheenv"
    else
        ex="export APPLICATION_CNAME_REGEX=$appregex"
        echo "$ex" >> /scripts/.apacheenv
    fi
fi

#Ensure tmp writeable
chmod a+w /tmp

sync;sleep 2

#Add default host entries
#/scripts/manage-etc-hosts.sh $APPLICATION_CNAME
#Not working with docker, due to mount point
