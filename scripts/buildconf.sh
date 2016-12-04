#!/bin/sh
outfile=$1

#DESC: Builds or updates a file based on env vars presented

sed  -i.bak "s/%SITENAME%/${SITE}/g" $outfile
sed  -i.bak "s/%APPLICATION_CNAME%/${APPLICATION_CNAME}/g" $outfile
sed  -i.bak "s/%APPLICATION_CNAME_REGEX%/${APPLICATION_CNAME_REGEX}/g" $outfile
sed  -i.bak "s/%DOCKER_NODE%/${DOCKER_NODE}/g" $outfile
sed  -i.bak "s/%DOCKER_DC%/${DOCKER_DC}/g" $outfile

