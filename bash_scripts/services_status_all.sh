#!/bin/bash
AUTHOR="averille-dev"
MONTH_YEAR="$(date +'%m-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$MONTH_YEAR.txt"
CURR_PWD=$(pwd)
FOLDERNAME="$CURR_PWD/~script_output"
mkdir -p "$FOLDERNAME"

OS_VERSION_IPs="$(sh ./get_ip_addr_version.sh)"
printf "%s %s\n%s\n" "$AUTHOR" "$FILENAME" "$OS_VERSION_IPs" | tee "$FOLDERNAME/$FILENAME"

systemctl -t service  | tee -a "$FOLDERNAME/$FILENAME"
sudo so-status | tee -a "$FOLDERNAME/$FILENAME"

for SERVICE in docker openvpn ufw ssh
do
    printf "\nchecking: %s\n" "$SERVICE"
    sudo systemctl status -l "$SERVICE".service | tee -a "$FOLDERNAME/$FILENAME"
done 

sudo /var/ossec/bin/ossec-control status | tee -a "$FOLDERNAME/$FILENAME"
journalctl -xe > "$FOLDERNAME/journalctl_xe_$MONTH_YEAR.txt"
sudo chown -R "$USER:$GROUP" "$FOLDERNAME"

printf "%s complete...\n" "${BASH_SOURCE[0]}"
