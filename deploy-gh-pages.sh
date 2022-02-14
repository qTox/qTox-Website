#!/bin/bash

# used in gh actions to deploy documentation to github pages


cd site/
cp en.html index.html

git init
git config user.name "qTox bot"
git config user.email "qTox@users.noreply.github.com"
git add .
git commit -m "Deploy to GH pages."
echo "$access_key" > /tmp/access_key
GIT_SSH_COMMAND="ssh -i /tmp/access_key" git push --force --quiet "git@github.com:qTox/qtox.github.io.git" master:master &> /dev/null
