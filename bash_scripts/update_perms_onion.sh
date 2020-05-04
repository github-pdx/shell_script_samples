#!/usr/bin/env bash
echo "_.:._.:._ "${BASH_SOURCE[0]}" started _.:._.:._"
AUTHOR="written by: averille.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
DIR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TODAY="$(date +'%m-%d-%Y')"
FILENAME="${BASH_SOURCE:2:-3}.txt"
DIRS="$(ls -d /$DIR_PATH/*/)"

FILE_PERM_LEVEL=0660
DIR_PERM_LEVEL=0770
SCRIPT_PERM_LEVEL=0770

printf "script:'$BASH_SOURCE' $AUTHOR
  files: $FILE_PERM_LEVEL
  dirs: $DIR_PERM_LEVEL
  scripts: $SCRIPT_PERM_LEVEL
perms:
0 = ---
1 = --x
2 = -w-
3 = -wx
4 = r-
5 = r-x
6 = rw-
7 = rwx
" 
USER=sysadmin
GROUP=t330-admins

for SHARE in XFS_2TB_HGST XFS_WDRE_ISOs XFS_WDRE_MUSIC XFS_WDRE_VMs
do
    cd "/media/$SHARE"
    printf "updating perms: '/media/$SHARE'\n"
    sudo chgrp -R $GROUP "/media/$SHARE"
    sudo chown -R $USER:$GROUP "/media/$SHARE"
    #sudo find $INPUT_DIR -type f -name "*.sh" -exec dos2unix {} \;
    #sudo find $INPUT_DIR -type f -name "*.txt" -exec dos2unix {} \;
    sudo find "/media/$SHARE" -type d -exec chmod -R $DIR_PERM_LEVEL {} \;
    sudo find "/media/$SHARE" -type f -name "*" -exec chmod -R $FILE_PERM_LEVEL {} \;
    sudo find "/media/$SHARE" -type f -name "*.sh" -exec chmod -R $SCRIPT_PERM_LEVEL {} \;
    sudo ls -ldZ "/media/$SHARE"
done

echo Script: $BASH_SOURCE Complete...
