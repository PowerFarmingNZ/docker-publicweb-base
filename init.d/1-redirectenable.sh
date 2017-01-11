#!/bin/sh
#Need escaped regex
appregex=$(echo "$APPLICATION_CNAME" | sed 's/\./\\./g')
export APPLICATION_CNAME_REGEX=$appregex

/scripts/buildconf.sh /etc/apache2/sites-available/templateredirector-default.conf /etc/apache2/sites-available/zzz-default.conf

#Enable default redirector
a2ensite zzz-default

#Disable sample site
a2dissite 000-default

