#!/bin/bash
AUTHOR="written by: github.pdx"
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
echo Running: $ABSOLUTE_PATH
MONTH_YEAR="$(date +'%m-%Y')"
FILENAME="${BASH_SOURCE:2:-3}_$TODAY.txt"
USER=sysadmin
GROUP=t330-admins
CURRENT_DIR=$(pwd)
FOLDERNAME="$CURRENT_DIR/~script_output"
mkdir -p "$FOLDERNAME"

OS_VERSION_IPs="$(sh ./linux_version_ipshow.sh)"
printf "$OS_VERSION_IPs\n"

HOSTNAME="$(hostname)"
CONSOLE="$USER@$HOSTNAME:$CURRENT_DIR$"

UDISKSCTL_CMD="udisksctl status"
UDISKSCTL="$($UDISKSCTL_CMD)"
printf "$CONSOLE $UDISKSCTL_CMD\n$UDISKSCTL" | tee "$FOLDERNAME/udisksctl_$MONTH_YEAR.txt"

BLKID_CMD="sudo blkid"
BLKID="$($BLKID_CMD)"
printf "$CONSOLE $BLKID_CMD\n$BLKID" | tee "$FOLDERNAME/blkid_$MONTH_YEAR.txt"

FDISK_CMD="sudo fdisk -l"
FDISK="$($FDISK_CMD)"
printf "$CONSOLE $FDISK_CMD\n$FDISK" | tee  "$FOLDERNAME/fdisk_$MONTH_YEAR.txt"

FSTAB_CMD="cat /etc/fstab"
FSTAB="$($FSTAB_CMD)"
printf "$CONSOLE $FSTAB_CMD\n$FSTAB" | tee "$FOLDERNAME/fstab_$MONTH_YEAR.txt"

LSBLK_CMD="sudo lsblk -mfb"
LSBLK="$($LSBLK_CMD)"
printf "$CONSOLE $LSBLK_CMD\n$LSBLK" | tee "$FOLDERNAME/lsblk_$MONTH_YEAR.txt"

sudo chown -R $USER:$GROUP $FOLDERNAME
echo Script: $BASH_SOURCE Complete...
