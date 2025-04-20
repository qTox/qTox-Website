#!/bin/bash

set -e

# used in gh actions to deploy documentation to github pages


cd site/
cp en.html index.html

git init
git checkout -b master
git config user.name "qTox bot"
git config user.email "qTox@users.noreply.github.com"
git add .
git commit -m "Deploy to GH pages."
touch /tmp/access_key
chmod 600 /tmp/access_key
echo "$WEBSITE_DEPLOY_KEY" > /tmp/access_key
GIT_SSH_COMMAND="ssh -i /tmp/access_key" git push --force --quiet "git@github.com:qTox/qtox.github.io.git" master:master

# Just to make sure
rm /tmp/access_key
