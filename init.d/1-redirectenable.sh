#!/bin/sh
./0-env.sh
touch /scripts/.apacheenv
source /scripts/.apacheenv

/scripts/buildconf.sh /etc/apache2/sites-available/templateredirector-default.conf /etc/apache2/sites-available/zzz-default.conf

#Enable default redirector
a2ensite zzz-default

#Disable sample site
a2dissite 000-default

