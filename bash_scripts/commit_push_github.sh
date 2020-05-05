#!/usr/bin/env bash
AUTHOR="github.pdx"
TODAY="$(date +'%m-%d-%Y')"
printf "script:'%s'\n%s\n" "$BASH_SOURCE" "$AUTHOR"

git config user.name github.pdx
git config user.email github.pdx@runbox.com
git config color.ui true
git config format.pretty oneline
git config --global core.autocrlf true

git config --list
sudo git remote -v

printf "enter commit comment for %s:" "$TODAY"
read input_comment

printf "pushing to remote\n"
sudo git add --all
sudo git commit -m "${input_comment}"
sudo git push origin master
git status

printf "script: '%s' complete\n" "$BASH_SOURCE"
