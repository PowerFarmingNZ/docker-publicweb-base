#!/bin/bash

#TODO: Handle refreshes...

#Handle CNAME and default redirection
if [ -z "$APPLICATION_CNAME" ]; then
    ALTCNAME=$(echo $VIRTUAL_HOST| awk -F',' '{print $1}')
    echo "WARNING: No CNAME in env, using $ALTCNAME from VIRTUAL_HOST"
    export APPLICATION_CNAME=$ALTCNAME

    echo "$ex" >> /scripts/.apacheenv
    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "CNAME already in .apacheenv"
    else
        ex="export APPLICATION_CNAME=$ALTCNAME"
    fi
fi

#Need escaped regex
if [ -z "$APPLICATION_CNAME_REGEX" ]; then
    appregex=$(echo "$APPLICATION_CNAME" | sed 's/\./\\./g')
    export APPLICATION_CNAME_REGEX=$appregex

    ex="export APPLICATION_CNAME_REGEX=$appregex"
    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "CNAME_REGEX already in .apacheenv"
    else
        echo "$ex" >> /scripts/.apacheenv
    fi
fi

if [ -z "$APPLICATION_REDIRECT" ]; then
    export APPLICATION_REDIRECT=true

    ex="export APPLICATION_REDIRECT=true"
    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "APPLICATION_REDIRECT already in .apacheenv"
    else
        echo "$ex" >> /scripts/.apacheenv
    fi
fi

#Moxie default TODO: Should be up the chain
if [ -z "$MOXIE_FILESYSTEM_ROOTPATH" ]; then
    export MOXIE_FILESYSTEM_ROOTPATH=/app/site/public/uploaded/

    ex="export MOXIE_FILESYSTEM_ROOTPATH=/app/site/public/uploaded/"
    touch /scripts/.apacheenv
    if grep -Fxq "$ex" /scripts/.apacheenv
    then
        echo "MOXIE_FILESYSTEM_ROOTPATH already in .apacheenv"
    else
        echo "$ex" >> /scripts/.apacheenv
    fi
fi

