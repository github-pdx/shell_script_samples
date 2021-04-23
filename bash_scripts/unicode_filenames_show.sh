#!/bin/bash
AUTHOR="averille-dev"
CURR_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"
TODAY="$(date +'%m-%d-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$TODAY.txt"
FOLDERNAME="$CURR_PWD/~script_output"
mkdir -p "$FOLDERNAME"
printf "%s %s\n" "$AUTHOR" "$FILENAME" | tee "$FOLDERNAME/$FILENAME"

printf "finding non-ASCII chars in filenames:\n%s\n" "$CURR_PWD" | tee -a "$FOLDERNAME/$FILENAME"

START=$(date +%s.%N)
i=0 

PWD_DIRS_ARR=("$(find "$CURR_PWD" -type d -exec readlink -f {} \;)")
#PWD_DIRS_ARR=("$(ls -d "$CURR_PWD"/*/)")

readarray -t SPLIT_ARR <<< "${PWD_DIRS_ARR[@]}"
#SPLIT_ARR=(${PWD_DIRS_ARR//$'\n'/ })
printf "found %d directories\n" "${#SPLIT_ARR[@]}"

# list subdirs in pwd loop if not files
for DIR_PATH in "${SPLIT_ARR[@]}"
do
    if [ ! -f "$DIR_PATH" ]
    then
        i=$((i+1))
        printf "share_%d: %s\n" "$i" "$DIR_PATH" | tee -a "$FOLDERNAME/$FILENAME"
        NON_ASCII_PATH="$(LC_ALL=C find "$DIR_PATH" -maxdepth 1 -name '*[! -~]*')"
        STR_LEN=${#NON_ASCII_PATH}
        if [ "$STR_LEN" -gt 4 ]
        then
            #UNICODE_FILENAME="$(basename -- "$NON_ASCII_PATH")"
            printf "%s\n" "$NON_ASCII_PATH" | tee -a "$FOLDERNAME/$FILENAME"
            #detox -r -v "$BASE_SHARE"/"$FOLDER" 
        fi
    fi
done 

END=$(date +%s.%N)
DIFF=$(echo "$END" - "$START" | bc)
printf "runtime: %0.03f seconds\n" "$DIFF" | tee -a "$FOLDERNAME/$FILENAME"

printf "%s complete...\n" "${BASH_SOURCE[0]}"
