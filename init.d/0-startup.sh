#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/apache2/* /tmp/apache*

#Ensure tmp writeable
chmod a+w /tmp

./0-env.sh

sync;sleep 2

#Add default host entries
#/scripts/manage-etc-hosts.sh $APPLICATION_CNAME
#Not working with docker, due to mount point
