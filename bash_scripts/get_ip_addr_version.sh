#!/bin/bash
if [ -f /etc/lsb-release ]; then
    OS_VERSION="$(lsb_release -sd)"
elif [ -f /etc/centos-release ]; then
    OS_VERSION="$(cat /etc/centos-release)"
fi
HOSTNAME="$(hostname)"
LOCAL_IP="$(hostname -I | awk '{ print $1}')"
GATEWAY_IP="$(ip -s route get 208.67.220.220 | head -n 1 | awk '{ print $1,$2,$3,$5,$7 }')"
TUNNEL_IP="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"
PUBLIC_IP="$(curl -s ipecho.net/plain ; echo)"

printf "  hostname:    %s
  os_version:  %s
  local_ip:    %s
  gateway_ip:  %s
  vpn_ip:      %s
  public_ip:   %s
" "$HOSTNAME" "$OS_VERSION" "$LOCAL_IP" "$GATEWAY_IP" "$TUNNEL_IP" "$PUBLIC_IP"
