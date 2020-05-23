#!/usr/bin/env bash
AUTHOR="github.pdx"
TODAY="$(date +'%m-%d-%Y')"
printf "%s %s\n" "$AUTHOR" "${BASH_SOURCE[0]}"

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

printf "%s complete...\n" "${BASH_SOURCE[0]}"
