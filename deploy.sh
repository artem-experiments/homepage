#!/bin/bash

set -e

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo $GITHUB_AUTH_SECRET > ~/.git-credentials && chmod 0600 ~/.git-credentials
git config --global credential.helper store
git config --global user.email "artem-bot@users.noreply.github.com"
git config --global user.name "Artems Bot"
git config --global push.default simple

rm -rf deployment
git clone https://github.com/artem-experiments/artem-experiments.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
git commit -m "rebuilding site `date`"
git push

cd ..
rm -rf deployment
