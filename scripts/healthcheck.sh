if [ $IGNORE_HEALTH ]; then exit 0; fi 

#General
if [ $APPLICATION_CNAME ]; then
    curl --fail http://$APPLICATION_CNAME/ || exit 1
    curl http://$APPLICATION_CNAME/ | grep "Fatal error" && exit 1
fi

exit 0
