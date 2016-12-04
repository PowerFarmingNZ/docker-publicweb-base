#!/bin/sh

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/apache2/* /tmp/apache*

#Handle CNAME and default redirection
if [ -z "$APPLICATION_CNAME" ]; then
    ALTCNAME=$(echo $VIRTUAL_HOST| awk -F',' '{print $1}')
    echo "WARNING: No CNAME in env, using $ALTCNAME from VIRTUAL_HOST"
    export APPLICATION_CNAME=$ALTCNAME
fi

#Need escaped regex
appregex=$(echo "$APPLICATION_CNAME" | sed 's/\./\\./g')
export APPLICATION_CNAME_REGEX=$appregex

sync;sleep 2