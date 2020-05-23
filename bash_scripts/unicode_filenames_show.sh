#!/bin/bash
AUTHOR="github.pdx"
TODAY="$(date +'%m-%d-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$TODAY.txt"
CURR_PWD=$(pwd)
FOLDERNAME="$CURR_PWD/~script_output"
mkdir -p "$FOLDERNAME"
printf "%s %s\n" "$AUTHOR" "$FILENAME" | tee "$FOLDERNAME/$FILENAME"

printf "finding non-ASCII chars in filenames\n" | tee -a "$FOLDERNAME/$FILENAME"

START=$(date +%s.%N)
i=0
PWD_DIRS_ARR=("$(ls -d "$CURR_PWD"/*/)")

# list subdirs in pwd loop through if not files. 
for DIR_PATH in $PWD_DIRS_ARR
do
    if [ ! -f "$DIR_PATH" ]
    then
        i=$((i+1))
        printf "share_$i: $DIR_PATH\n" | tee -a "$FOLDERNAME/$FILENAME"
        NON_ASCII_PATH="$(LC_ALL=C find $DIR_PATH -maxdepth 1 -name '*[! -~]*')"
        STR_LEN=${#NON_ASCII_PATH}
        if [ "$STR_LEN" -gt 4 ]
        then
            UNICODE_FILENAME="$(basename -- "$NON_ASCII_PATH")"
            printf "$NON_ASCII_PATH\n" | tee -a "$FOLDERNAME/$FILENAME"
            #detox -r -v "$BASE_SHARE"/"$FOLDER" 
        fi
    fi
done 

END=$(date +%s.%N)
DIFF=$(echo "$END" - "$START" | bc)
printf "runtime: %0.03f seconds\n" "$DIFF" | tee -a "$FOLDERNAME/$FILENAME"

printf "%s complete...\n" "${BASH_SOURCE[0]}"
