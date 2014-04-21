#!/bin/bash
#
#
# 	Authors ::->>	 i3-Arch, trewchainz, t60r  <<-::
#
#		Made to install archlinux
#		
#		VERSION 1.1-BETA
#	
#	WARNING : THIS SCRIPT IS CURRENTLY BEING DEVELOPED
#			RUN AT YOUR OWN RISK
#
#	Reminder  -  Add option for LUKS
############################################
printf " \n WELCOME TO i3 ARCHLINUX INSTALL SCRIPT\n"
sleep 3
asd() {
cat <<"EOT"

    #                                                          ### 
   # #   #####   ####  #    # #      # #    # #    # #    #    ### 
  #   #  #    # #    # #    # #      # ##   # #    #  #  #     ### 
 #     # #    # #      ###### #      # # #  # #    #   ##      ###  
 ####### #####  #      #    # #      # #  # # #    #   ##          
 #     # #   #  #    # #    # #      # #   ## #    #  #  #     ### 
 #     # #    #  ####  #    # ###### # #    #  ####  #    #    ### 
EOT
}
asd
printf "\n \n \n Running lsblk to list block devices\n"
lsblk
printf " \n Which Drive would you like to install to\n"
printf " i.e - /dev/sda\n"
printf " WARNING : /dev/sda may not be empty for you\n"
read yourdrive
echo "yourdrive=$yourdrive" > config.sh
printf " CREATE ::  boot - root -  home  - swap  partitions\n"
printf " Would you like to use cfdisk or fdisk ?\n"
read toolchoice
if [ "$toolchoice" == cfdisk -o "$toolchoice" == CFDISK ]
	then
cfdisk $yourdrive
	else
fdisk $yourdrive
fi
touch config.sh #create file to store bootpart, rewtpart, homepart, swappart for chrootnset.sh
printf " Enter Your Boot Partition:\n"
read bootpart
echo "bootpart=$bootpart" >> config.sh
mkfs.ext4 "$bootpart" -L bootfs
printf " Enter Your Root Partition:\n" 
printf " i.e  /dev/sda1\n"
read rewtpart
echo "rewtpart=$rewtpart" >> config.sh
mkfs.ext4 "$rewtpart" -L rootfs
printf " Enter Your Home Partition:\n"
read homepart
echo "homepart=$homepart" >> config.sh
mkfs.ext4 "$homepart"
printf " What is your swap partition:\n"
read swappart
echo "swappart=$swappart" >> config.sh
mkswap "$swappart" -L swapfs
printf " Setting up install\n"
	pacman -Syy
	pacman -S rsync --noconfirm
	mount $rewtpart /mnt
	mkdir -pv /mnt/var/lib/pacman
	pacman -r /mnt -Sy base base-devel --noconfirm
	pacman -r /mnt -Syy
	pacman -r /mnt -S rsync grub --noconfirm
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	mount --bind /dev/ /mnt/dev
	mount --bind /sys/ /mnt/sys
	mount --bind /proc/ /mnt/proc
	cp chrootnset.sh /mnt
	cp config.sh /mnt
	chroot /mnt bash chrootnset.sh
