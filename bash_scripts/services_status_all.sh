#!/bin/bash
AUTHOR="github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MONTH_YEAR="$(date +'%m-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$MONTH_YEAR.txt"
CURR_PWD=$(pwd)
FOLDERNAME="$CURR_PWD"/"~script_output"
mkdir -p "$FOLDERNAME"
OS_VERSION_IPs="$(sh ./linux_version_ipshow.sh)"

printf "script: '%s'\n%s\n%s\n%s\n" "$BASH_SOURCE" "$AUTHOR" "$FILENAME" "$OS_VERSION_IPs" | tee "$FOLDERNAME"/"$FILENAME"

systemctl -t service  | tee -a "$FOLDERNAME"/"$FILENAME"

for SERVICE in docker openvpn ossec ufw ssh
do
    printf "\nchecking: %s\n" "$SERVICE"
    sudo systemctl status -l "$SERVICE".service | tee -a "$FOLDERNAME"/"$FILENAME"
done 

sudo journalctl -xe > "$FOLDERNAME"/"journalctl_xe_$MONTH_YEAR.txt"
sudo chown -R "$USER":"$GROUP" "$FOLDERNAME"

printf "script: '%s' complete\n" "$BASH_SOURCE"
