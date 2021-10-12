#!/bin/bash
##############
## i3-Arch  ##   So simple, a caveman could write it....
##############

ip a
printf "\033[1m ${green}  [ ie: what starts with enp (( enp0s3 )) ]\n Enter your iface name:  \033[0m"
read ifacename

echo "[Match]" > /etc/systemd/network/20-wired.network
echo "Name=$ifacename" >> /etc/systemd/network/20-wired.network
echo "[Network]" >> /etc/systemd/network/20-wired.network
echo "DHCP=yes" >> /etc/systemd/network/20-wired.network

systemctl start systemd-networkd.service
systemctl enable systemd-networkd.service

#EOF
