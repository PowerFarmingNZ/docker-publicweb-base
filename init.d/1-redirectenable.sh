#!/bin/sh

/scripts/buildconf.sh /etc/apache2/sites-available/zzz-default.conf

#Enable default redirector
a2ensite zzz-default

#Disable sample site
a2dissite 000-default

