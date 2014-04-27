#!/bin/bash
#
#
# 	Authors ::->>	 i3-Arch, trewchainz, t60r  <<-::
#
#		Made to install archlinux
#
#		VERSION 1.2-BETA
#
#	WARNING : THIS SCRIPT IS CURRENTLY BEING DEVELOPED
#			RUN AT YOUR OWN RISK
#
#	Reminder  -  Add option for LUKS
#
#   Note : Since this script directly modifies the system
#        It is required to be operated as root
############################################

############
#
#  STATUS: NOT WORKING
#  REASON:  Grub is looking for UUID's
#  LAST RAN = 4-26-2014 
#	
########################

#COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
setfont Lat2-Terminus16
printf " \033[1m \n ${white} WELCOME TO ${red} ARCHLINUX ${white} INSTALL SCRIPT \033[0m \n"
banner() {
cat <<"EOT"
    #                                                          ###
   # #   #####   ####  #    # #      # #    # #    # #    #    ###
  #   #  #    # #    # #    # #      # ##   # #    #  #  #     ###
 #     # #    # #      ###### #      # # #  # #    #   ##      ###
 ####### #####  #      #    # #      # #  # # #    #   ##
 #     # #   #  #    # #    # #      # #   ## #    #  #  #     ###
 #     # #    #  ####  #    # ###### # #    #  ####  #    #    ###
EOT
sleep 3
}

disk() {
	printf " \033[1m \n ${white} Which drive would you like to install to?:${red} i.e. ${white}/dev/sda \n \033[0m "
	printf " \033[1m ${red} WARNING:${green}/dev/sda${white}may not be empty on your system\n \033[0m "
	printf " \033[1m \n ${yellow} Drive:${white}\033[0m "
	read yourdrive
	printf " \033[1m ${white} \n Partition with ${green} cfdisk ${white} or ${green} fdisk ? \n \033[0m"
	printf " \033[1m \n ${yellow} Tool Choice:${white}\033[0m"
	read toolchoice
	if [ "$toolchoice" == cfdisk -o "$toolchoice" == CFDISK ]
		then
			cfdisk $yourdrive
		else
			fdisk $yourdrive
	fi
}

# If you don't know how to partition properly, you don't need this OS.
ASKme() {
	printf "\033[1m \n ${white} Running lsblk to list block devices\n \033[0m"
	lsblk |grep -v "loop*"
	printf " \033[1m \n ${white} ENTER YOUR CHOICE OF ${green}[1]${yellow}[2]${red}[3] \n \033[0m"
	printf " \033[1m  ${red} (1)${white}boot and root partitions \n \033[0m"
	printf " \033[1m  ${red}(2)${white}boot, root, home partitions \n \033[0m "
	printf " \033[1m  ${red}(3)${white}boot, root, home, swap partitions \n \n \033[0m"
	sleep 2
	printf " \033[1m ${red} * REMINDER * ${white}\n\n IF PLANNING TO USE SYSLINUX \n \033[0m"
	printf " \033[1m ${white}MAKE SURE BOOT PARTITION IS ${green}/dev/sda1 \n \033[0m"
	printf " \033[1m ${white}\n SELECT ${green}[1] ${yellow}[2] ${white}or${red} [3] \n \033[0m"
	printf " \033[1m ${yellow}Your Selection:${white}\033[0m"
	read thechoiceman
	echo "thechoiceman=$thechoiceman" >> config.sh
}

SMALLpart() {
	printf " \033[1m ${white}\n Enter your Boot Partition: ${red}i.e. ${green}/dev/sda1 \n \033[0m"
    printf " \033[1m \n ${yellow}Boot Partition: ${white}\033[0m"    
		read bootpart
        echo "bootpart=$bootpart" >> config.sh
        mkfs.ext4 "$bootpart" -L bootfs
	printf " \033[1m ${white}\n Enter your Root Partition:${red} i.e. ${green}/dev/sda2 \n \033[0m"
    printf " \033[1m ${yellow}\n Root Partition: ${white}\033[0m"
		read rewtpart
        echo "rewtpart=$rewtpart" >> config.sh
        mkfs.ext4 "$rewtpart" -L rootfs
}

HALFpart() {
        printf " \n Enter your Boot Partition: i.e. /dev/sda1 \n"
        printf " \n Boot Partition: "
		read bootpart
        echo "bootpart=$bootpart" >> config.sh
        mkfs.ext4 "$bootpart" -L bootfs
        printf " \n Enter your Root Partition: i.e. /dev/sda2 \n"
        printf " \n Root Partition: "
		read rewtpart
        echo "rewtpart=$rewtpart" >> config.sh
        mkfs.ext4 "$rewtpart" -L rootfs
	printf " \n Enter your Home Partition: i.e. /dev/sda3 \n"
    printf " \n Home Partition: "
		read homepart
        echo "homepart=$homepart" >> config.sh
        mkfs.ext4 "$homepart"
}

FULLpart() {

	printf " \n Enter your Boot Partition: i.e. /dev/sda1 \n"
	printf " \n Boot Partition: "
	read bootpart
	echo "bootpart=$bootpart" >> config.sh
	mkfs.ext4 "$bootpart" -L bootfs
	printf " \n Enter your Root Partition: i.e. /dev/sda2 \n"
	printf " \n Root Partition: "
	read rewtpart
	echo "rewtpart=$rewtpart" >> config.sh
	mkfs.ext4 "$rewtpart" -L rootfs
	printf " \n Enter your Home Partition: i.e. /dev/sda3 \n"
	printf " \n Home Partition: "
	read homepart
	echo "homepart=$homepart" >> config.sh
	mkfs.ext4 "$homepart"
	printf " \n Enter your Swap Partition: i.e. /dev/sda4 \n"
	printf " \n Swap Partition: "
	read swappart
	echo "swappart=$swappart" >> config.sh
	mkswap "$swappart" -L swapfs
}

pkgmntchroot() {
	printf " Setting up install...\n"
	pacman -Syyu --noconfirm
	pacman -S rsync grub --noconfirm
	mount $rewtpart /mnt
	mkdir -pv /mnt/var/lib/pacman
	pacman -r /mnt -Syy base base-devel rsync --noconfirm
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	mount --bind /dev/ /mnt/dev
	mount --bind /sys/ /mnt/sys
	mount --bind /proc/ /mnt/proc
	cp chrootnset.sh /mnt
	cp config.sh /mnt
	genfstab -L -p /mnt >> /mnt/etc/fstab
	chroot /mnt bash chrootnset.sh
}

grubinst() {
	grub-install --boot-directory=/mnt/boot $yourdrive
	grub-mkconfig -o /mnt/boot/grub/grub.cfg
	echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg
	UUIDboot=`lsblk -no UUID $bootpart`
	UUIDrewt=`lsblk -no UUID $rewtpart`
	echo " set root=/dev/disk/by-uuid/$UUIDboot " >> /mnt/boot/grub/grub.cfg
	echo " linux /boot/vmlinuz-linux root=/dev/disk/by-uuid/$UUIDrewt " >> /mnt/boot/grub/grub.cfg
	echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg
	echo " }" >> /mnt/boot/grub/grub.cfg
}

syslinuxinst() { 
	printf " \n Warning! /boot/ MUST be on /dev/sda1 for this function to work! \n"
	syslinux-install_update -i -a -m
	sed '/sda3/ s//sda1/' /mnt/boot/syslinux/syslinux.cfg >> syslinux.cfg 
	mv syslinux.cfg /mnt/boot/syslinux/syslinux.cfg
} #ONLY WORKS ON /dev/sda1 AS BOOT!!!

CALLpart() {
	if [ "$thechoiceman" -eq 3 ]
    		then
    		    FULLpart
		elif [ "$thechoiceman" -eq 2 ]
		then
		    HALFpart
		elif [ "$thechoiceman" -eq 1 ]
		then
		    SMALLpart
		else
		    SMALLpart
	fi
}

BOOTload() {
	printf " \n CHOOSE YOUR BOOTLOADER \n"
	printf " \n (1) For Grub \n "
	printf " \n (2) For SysLinux \n " 
	printf " \n CHOICE: "
	read bootloadchoice
	if [ "$bootloadchoice" -eq 1 ]
		then
			grubinst
		elif [ "$bootloadchoice" -eq 2 ]
		then
			syslinuxinst
		else
			grubinst
	fi
}		

main() {
	banner
	ASKme     	 ## ASK NUMBER OF PARTITIONS
	disk	         ## PARTITION WITH CFDISK or FDISK
	touch config.sh  ## Create file to store bootpart, rewtpart, homepart, swappart for chroot
        CALLpart 	 ## CALL PARTITIONING IF STATEMENT
	pkgmntchroot 	 ## Setup packages and mounts, then chroot hook for additional setup w/ chrootnset.sh
	BOOTload 	 ## CHOOSE BOOTLOADER ## Runs after chrootnset.sh
	printf " \n COMPLETE !  \n "
	printf " \n SHUT DOWN SYSTEM AND THEN \n"
	printf " \n REMOVE LIVE IMAGE \n "
	printf " \n AND REBOOT SYSTEM ! \n"
}

main
