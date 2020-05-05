#!/usr/bin/env bash
AUTHOR="github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
DIR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURR_PWD=$(pwd)
TODAY="$(date +'%m-%d-%Y')"
FILENAME="${BASH_SOURCE:2:-3}.txt"

USER=sysadmin
GROUP=t330-admins
FILE_PERM_LEVEL=0660
DIR_PERM_LEVEL=0770
SCRIPT_PERM_LEVEL=0770

printf "script: '%s'
  files:   %s
  dirs:    %s
  scripts: %s
  perms:
    0 = ---
    1 = --x
    2 = -w-
    3 = -wx
    4 = r-
    5 = r-x
    6 = rw-
    7 = rwx
" "$BASH_SOURCE" "$FILE_PERM_LEVEL" "$DIR_PERM_LEVEL" "$SCRIPT_PERM_LEVEL"

PWD_SUBDIRS="$(ls -d $CURR_PWD/*/)"
SUBDIR_PATHLIST="${d:-$CURR_PWD}"

for SHARE in $PWD_SUBDIRS
do
    cd "$SHARE"
    printf "updating perms:\n'%s'\n" "$SHARE"
    sudo chgrp -R "$GROUP" "$SHARE"
    sudo chown -R "$USER":"$GROUP" "$SHARE"
    #sudo find $INPUT_DIR -type f -name "*.sh" -exec dos2unix {} \;
    #sudo find $INPUT_DIR -type f -name "*.txt" -exec dos2unix {} \;
    sudo find "$SHARE" -type d -exec chmod -R "$DIR_PERM_LEVEL" {} \;
    sudo find "$SHARE" -type f -name "*" -exec chmod -R "$FILE_PERM_LEVEL" {} \;
    sudo find "$SHARE" -type f -name "*.sh" -exec chmod -R "$SCRIPT_PERM_LEVEL" {} \;
    ls -al
done

printf "script: '%s' complete\n" "$BASH_SOURCE"