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
" > $FOLDERNAME/$FILENAME

sudo cp /etc/fstab "/etc/fstab_$TODAY.txt"
sudo cp /etc/fstab "$FOLDERNAME/fstab_$TODAY.txt"

sudo apt-get -y update
sudo apt-get -y install exfat-fuse exfat-utils
sudo apt-get -y install ntfs-3g

printf "\nOpen 'gnome-disks' to see new HDD UUIDs 
auto-mount on boot from GUI will append to /etc/fstab automatically \n"

sudo groupadd t330-admins -g 33033
sudo usermod -a -G t330-admins sysadmin
grep 't330-admins' /etc/group | tee -a $FOLDERNAME/$FILENAME

for SHARE in XFS_2TB_HGST XFS_WDRE_MUSIC XFS_WDRE_VMs XFS_WDRE_ISOs
do
    if [ ! -d "/media/$SHARE" ]
    then
        printf "\nAdding: /media/$SHARE \n"
        sudo mkdir -p /media/$SHARE
        sudo chgrp -R $GROUP /media/$SHARE 
        sudo chmod -R g=rwx /media/$SHARE
        sudo chmod -R 0770 /media/$SHARE
        sudo chown -R $USER:$GROUP /media/$SHARE
    fi
done 
stat -c'%a %n' /media/* | tee -a $FOLDERNAME/$FILENAME
sudo chown -R $USER:$GROUP $FOLDERNAME

echo Script: $BASH_SOURCE Complete...
