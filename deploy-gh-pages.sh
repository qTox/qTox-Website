#!/bin/bash

# used in travis to deploy documentation to github pages


cd site/
cp en.html index.html

git init
git config user.name "Travis CI"
git config user.email "qTox@users.noreply.github.com"
git add .
git commit -m "Deploy to GH pages."
git push --force --quiet "https://${GH_TOKEN}@github.com/qTox/qtox.github.io.git" master:master &> /dev/null
