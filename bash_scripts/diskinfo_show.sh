#!/bin/bash
AUTHOR="github.pdx"
MONTH_YEAR="$(date +'%m-%Y')"
USER=sysadmin
GROUP=t330-admins
CURR_PWD=$(pwd)
FOLDERNAME="$CURR_PWD"/"~script_output"
mkdir -p "$FOLDERNAME"

OS_VERSION_IPs="$(sh ./linux_version_ipshow.sh)"
printf "%s\n" "$OS_VERSION_IPs"

HOSTNAME="$(hostname)"
CONSOLE="$USER"@"$HOSTNAME:"

UDISKSCTL_CMD="udisksctl status"
UDISKSCTL="$($UDISKSCTL_CMD)"
printf "%s %s\n%s" "$CONSOLE" "$UDISKSCTL_CMD" "$UDISKSCTL" | tee "$FOLDERNAME"/"udisksctl_$MONTH_YEAR.txt"

BLKID_CMD="sudo blkid"
BLKID="$($BLKID_CMD)"
printf "%s %s\n%s" "$CONSOLE" "$BLKID_CMD" "$BLKID" | tee "$FOLDERNAME"/"blkid_$MONTH_YEAR.txt"

FDISK_CMD="sudo fdisk -l"
FDISK="$($FDISK_CMD)"
printf "%s %s\n%s" "$CONSOLE" "$FDISK_CMD" "$FDISK" | tee  "$FOLDERNAME"/"fdisk_$MONTH_YEAR.txt"

FSTAB_CMD="cat /etc/fstab"
FSTAB="$($FSTAB_CMD)"
printf "%s %s\n%s" "$CONSOLE" "$FSTAB_CMD" "$FSTAB" | tee "$FOLDERNAME"/"fstab_$MONTH_YEAR.txt"

LSBLK_CMD="sudo lsblk -mfb"
LSBLK="$($LSBLK_CMD)"
printf "%s %s\n%s" "$CONSOLE" "$LSBLK_CMD" "$LSBLK" | tee "$FOLDERNAME"/"lsblk_$MONTH_YEAR.txt"

sudo chown -R "$USER":"$GROUP" "$FOLDERNAME"
printf "script: '%s' complete\n" "$BASH_SOURCE"
