#!/bin/bash

CURRENTDIR=`pwd`
WORKDIR=/tmp/ooo-site
ME=`basename $0`

rm -rf $WORKDIR
mkdir -p $WORKDIR

# now bake the site
./bake.sh -b . $WORKDIR
cp assets/.htaccess $WORKDIR

# push all of the results to asf-site
git checkout asf-staging
git clean -f -d
git pull origin asf-staging
rm -rf content
mkdir content
cp -a $WORKDIR/* content
cp -a $WORKDIR/.htaccess content
git add -f content
git commit -m "git-site-role commit from $ME"
git push -f origin asf-staging
