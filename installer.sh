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
printf " \n WELCOME TO i3 ARCHLINUX INSTALL SCRIPT\n"
banner () {
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

disk () {
	printf " \n Which drive would you like to install to?: i.e. /dev/sda\n"
	printf " WARNING : /dev/sda may not be empty on your system\n"
	read yourdrive
	if [ "$toolchoice" == cfdisk -o "$toolchoice" == CFDISK ]
		then
			cfdisk $yourdrive
		else
		fdisk $yourdrive
	fi
}

# If you don't know how to partition properly, you don't need this OS.
ASKme () {
	printf "\n Running lsblk to list block devices\n"
	lsblk |grep -v "loop*"
	printf " \n  ENTER YOUR CHOICE OF [1] [2] [3] \n"
	printf "  (1) boot and root partitions \n "
	printf " (2) boot, root, home partitions \n "
	printf " (3) boot, root, home, swap partitions \n \n "
	sleep 2
	printf " * REMINDER *\n\n IF PLANNING TO USE SYSLINUX \n "
	printf "  MAKE SURE BOOT PARTITION IS /dev/sda1 \n "
	printf " \n SELECT [1] [2] or [3] \n"
	printf " Selection: "
	read thechoiceman
	echo "thechoiceman=$thechoiceman" >> config.sh
}

SMALLpart () {
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
}

HALFpart () {
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

FULLpart () {

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

pkgmntchroot () {
	printf " Setting up install...\n"
	pacman -Syu
	pacman -S rsync grub --noconfirm
	mount $rewtpart /mnt
	mkdir -pv /mnt/var/lib/pacman
	pacman -r /mnt -Syy base base-devel rsync grub --noconfirm
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	mount --bind /dev/ /mnt/dev
	mount --bind /sys/ /mnt/sys
	mount --bind /proc/ /mnt/proc
	cp chrootnset.sh /mnt
	cp config.sh /mnt
	chroot /mnt bash chrootnset.sh
}

grub () {
	grub-install --boot-directory=/mnt/boot $yourdrive
	grub-mkconfig -o /mnt/boot/grub/grub.cfg
	echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg
	echo " set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg
	echo " linux /boot/vmlinuz-linux root=$rewtpart " >> /mnt/boot/grub/grub.cfg
	echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg
	echo " }" >> /mnt/boot/grub/grub.cfg
}

syslinux () { 
	printf " \n Warning! /boot/ MUST be on /dev/sda1 for this function to work! \n"
	syslinux-install_update -i -a -m
	sed '/sda3/ s//sda1/' /mnt/boot/syslinux/syslinux.cfg >> syslinux.cfg 
	mv syslinux.cfg /mnt/boot/syslinux/syslinux.cfg
} #ONLY WORKS ON /dev/sda1 AS BOOT!!!

CALLpart () {
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

BOOTload () {
	printf " \n CHOOSE YOUR BOOTLOADER \n"
	printf " \n (1) For Grub \n "
	printf " \n (2) For SysLinux \n " 
	read bootloadchoice
	if [ "$bootloadchoice" -eq 1 ]
		then
			grub
		elif [ "$bootloadchoice" -eq 2 ]
			then
				syslinux
		else
			grub
	fi
}		

main () {
	banner
	ASKme	## ASK NUMBER OF PARTITIONS
	disk	## PARTITION WITH CFDISK or FDISK
	touch config.sh ## Create file to store bootpart, rewtpart, homepart, swappart for chroot
    	CALLpart 		## CALL PARTITIONING IF STATEMENT
	pkgmntchroot 	## Setup packages and mounts, then chroot hook for additional setup w/ chrootnset.sh
	BOOTload 	## CHOOSE BOOTLOADER ## Runs after chrootnset.sh
	printf " \n COMPLETE !  \n "
	printf " \n SHUT DOWN SYSTEM AND THEN \n"
	printf " \n REMOVE LIVE IMAGE \n "
	printf " \n AND REBOOT SYSTEM ! \n"
}

main
