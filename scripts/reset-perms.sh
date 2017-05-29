#!/bin/bash

WEBDIR=/app/site
WEBUSER=www-data

if [ -n "$(find $WEBDIR -user "$WEBUSER" -print -prune -o -prune)" ]; then
    echo "The web directory ($WEBDIR) is owned by $WEBUSER."
else
    echo "The web directory ($WEBDIR) is not owned by $WEBUSER.  Running chown to fix this."
    chown $WEBUSER:$WEBUSER -R $WEBDIR
fi
