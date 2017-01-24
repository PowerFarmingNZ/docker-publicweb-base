#!/bin/sh
/scripts/init.d/0-env.sh
touch /scripts/.apacheenv
. /scripts/.apacheenv

if [ "$APPLICATION_REDIRECT" = "true" ]; then
    echo "Enabling default redirector"
    /scripts/buildconf.sh /etc/apache2/sites-available/templateredirector-default.conf /etc/apache2/sites-available/zzz-default.conf

    #Enable default redirector
    a2ensite zzz-default

    #Disable sample site
    a2dissite 000-default
else
    #Disable default redirector
    a2dissite zzz-default
fi

