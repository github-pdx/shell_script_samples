#!/bin/bash
AUTHOR="written by: github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
echo Running: $ABSOLUTE_PATH
TODAY="$(date +'%m-%d-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$TODAY.txt"
USER=sysadmin
GROUP=t330-admins
CURRENT_DIR=$(pwd)
FOLDERNAME="$CURRENT_DIR/~script_output"
mkdir -p "$FOLDERNAME"
OS_VERSION_IPs="$(sh ./linux_version_ipshow.sh)"
printf "script:'$BASH_SOURCE' $AUTHOR
$FOLDERNAME/$FILENAME
$OS_VERSION_IPs\n
"
BASE_SHARE="/media/XFS_2TB_HGST"
printf "Locating NON-ASCII chars in filenames:\n" 
cd $BASE_SHARE

START=$(date +%s.%N)
printf "$BASH_SOURCE\n$BASE_SHARE\n<-- start: $START\n" | tee "$BASE_SHARE/$FILENAME"
COUNTER=0
# find "/media/HDD1" -iname desktop.ini -print
# find "/media/HDD2" -iname desktop.ini -delete

DIR_LIST="${d:-$BASE_SHARE}"

#for DIR_PATH in $BASE_SHARE
for DIR_PATH in $DIR_LIST
do
    if [ ! -f "$DIR_PATH" ]
    then
        COUNTER=$[COUNTER+1]
        cd "$DIR_PATH"
        CURRENT_DIR=$(pwd)
        NON_ASCII="$(LC_ALL=C find "$DIR_PATH" -name '*[! -~]*')"
        STR_LEN=${#NON_ASCII}
        if [ $STR_LEN -gt 4 ]
        then
            printf "SHARE_$COUNTER: '$DIR_PATH'\n" | tee -a "$BASE_SHARE/$FILENAME"
            printf "$NON_ASCII\n" | tee -a "$BASE_SHARE/$FILENAME"
            #detox -r -v "$DIR_PATH"
        fi
    fi
done 

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
printf "  --> end: $END\n  diff: $DIFF seconds" | tee -a "$BASE_SHARE/$FILENAME"

echo Script: $BASH_SOURCE Complete...
