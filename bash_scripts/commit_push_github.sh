#!/usr/bin/env bash
AUTHOR="written by: github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
echo Running: $ABSOLUTE_PATH
USER=sysadmin
GROUP=t330-admins
CURRENT_DIR=$(pwd)
TODAY="$(date +'%m-%d-%Y')"
printf "script:'$BASH_SOURCE' $AUTHOR\n"

git config user.name github.pdx
git config user.email github.pdx@runbox.com
git config color.ui true
git config format.pretty oneline
git config --global core.autocrlf true

git config --list
sudo git remote -v

printf "enter commit comment for $TODAY:"
read input_comment

printf "pushing to remote\n"
sudo git add --all
sudo git commit -m "${input_comment}"
sudo git push origin master
git status

echo Script: $BASH_SOURCE Complete...
