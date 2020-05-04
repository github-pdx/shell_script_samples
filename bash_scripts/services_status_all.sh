#!/bin/bash
AUTHOR="written by: github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
echo Running: $ABSOLUTE_PATH
MONTH_YEAR="$(date +'%m-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$MONTH_YEAR.txt"
USER=sysadmin
GROUP=t330-admins
CURRENT_DIR=$(pwd)
FOLDERNAME="$CURRENT_DIR/~script_output"
mkdir -p "$FOLDERNAME"
OS_VERSION_IPs="$(sh ./linux_version_ipshow.sh)"
printf "script:'$BASH_SOURCE' $AUTHOR
$FOLDERNAME/$FILENAME
$OS_VERSION_IPs\n
" > $FOLDERNAME/$FILENAME

systemctl -t service  | tee -a $FOLDERNAME/$FILENAME

for SERVICE in docker openvpn ossec ufw ssh
do
    printf "\nChecking: $SERVICE \n"
    sudo systemctl status -l $SERVICE.service | tee -a $FOLDERNAME/$FILENAME
done 

sudo journalctl -xe > "$FOLDERNAME/journalctl_xe_$MONTH_YEAR.txt"
sudo chown -R $USER:$GROUP $FOLDERNAME

echo Script: $BASH_SOURCE Complete...
