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

#FONT
setfont Lat2-Terminus16

#COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)


banner() {
	printf " \033[1m \n ${white} WELCOME TO ${red} ARCHLINUX ${white} INSTALL SCRIPT \033[0m \n"
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
	printf " \033[1m ${red} WARNING:${green} /dev/sda ${white}may not be empty on your system\n \033[0m "
	printf " \033[1m \n ${yellow} Drive: ${white}\033[0m "
	read yourdrive
	echo "yourdrive=$yourdrive" >> config.sh
	printf " \033[1m ${white} \n Partition with ${green} cfdisk ${white} or ${green} fdisk ? \n \033[0m"
	printf " \033[1m \n ${yellow} Tool Choice: ${white}\033[0m"
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
	printf " \033[1m  ${red}(1)${white}boot and root partitions \n \033[0m"
	printf " \033[1m  ${red}(2)${white}boot, root, home partitions \n \033[0m "
	printf " \033[1m  ${red}(3)${white}boot, root, home, swap partitions \n \n \033[0m"
	printf " \033[1m ${red} * REMINDER * ${white}\n\n IF PLANNING TO USE SYSLINUX \n \033[0m"
	printf " \033[1m ${white}MAKE SURE BOOT PARTITION IS ${green}/dev/sda1 \n \033[0m"
	printf " \033[1m ${white}\n SELECT ${green}[1] ${yellow}[2] ${white}or${red} [3] \n \033[0m"
	printf " \033[1m ${yellow}Your Selection: ${white}\033[0m"
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
        printf " \033[1m \n${white} Enter your Boot Partition: ${red}i.e. /dev/sda1 \n \033[0m"
        printf " \033[1m \n ${yellow}Boot Partition: ${white} \033[0m"
		read bootpart
        echo "bootpart=$bootpart" >> config.sh
        mkfs.ext4 "$bootpart" -L bootfs
        printf " \033[1m \n ${white}Enter your Root Partition: ${red}i.e. /dev/sda2 \n \033[0m"
        printf " \033[1m \n  ${yellow}Root Partition: ${white} \033[0m"
		read rewtpart
        echo "rewtpart=$rewtpart" >> config.sh
        mkfs.ext4 "$rewtpart" -L rootfs
	printf " \033[1m \n ${white}Enter your Home Partition: ${red}i.e. /dev/sda3 \n \033[0m"
    printf " \033[1m \n ${yellow}Home Partition: ${white} \033[0m"
		read homepart
        echo "homepart=$homepart" >> config.sh
        mkfs.ext4 "$homepart"
}

FULLpart() {

	printf "\033[1m \n ${white}Enter your Boot Partition: ${red}i.e. /dev/sda1 \n \033[0m"
	printf "\033[1m \n ${yellow}Boot Partition: ${white}\033[0m"
	read bootpart
	echo "bootpart=$bootpart" >> config.sh
	mkfs.ext4 "$bootpart" -L bootfs
	printf "\033[1m \n ${white}Enter your Root Partition: ${red}i.e. /dev/sda2 \n \033[0m"
	printf " \033[1m \n ${yellow}Root Partition: ${white}\033[0m"
	read rewtpart
	echo "rewtpart=$rewtpart" >> config.sh
	mkfs.ext4 "$rewtpart" -L rootfs
	printf " \033[1m \n ${white}Enter your Home Partition: ${red}i.e. /dev/sda3 \n \033[0m"
	printf "\033[1m \n ${yellow}Home Partition: ${white}\033[0m"
	read homepart
	echo "homepart=$homepart" >> config.sh
	mkfs.ext4 "$homepart"
	printf "\033[1m \n ${white}Enter your Swap Partition: ${red}i.e. /dev/sda4 \n \033[0m"
	printf "\033[0m \n ${yellow}Swap Partition: ${white}\033[0m"
	read swappart
	echo "swappart=$swappart" >> config.sh
	mkswap "$swappart" -L swapfs
}

pkgmntchroot() {
	printf " Setting up install...\n"
	pacman -Syy --noconfirm
	pacman -S rsync grub os-prober --noconfirm
	mount $rewtpart /mnt
	mkdir -v /mnt/{home,boot,sys,proc,dev}
	mkdir -pv /mnt/var/lib/pacman
	mount $bootpart /mnt/boot
	mount $homepart /mnt/home
	mount --bind /proc /mnt/proc
	mount --bind /sys /mnt/sys
	mount --bind /dev /mnt/dev
	pacstrap -i /mnt base base-devel grub os-prober rsync --noconfirm
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	cp chrootnset.sh config.sh /mnt
	arch-chroot /mnt bash chrootnset.sh
}


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



main() {
	banner
	ASKme     	 ## ASK NUMBER OF PARTITIONS
	disk	         ## PARTITION WITH CFDISK or FDISK
	touch config.sh  ## Create file to store bootpart, rewtpart, homepart, swappart for chroot
    CALLpart 	 ## CALL PARTITIONING IF STATEMENT
	pkgmntchroot 	 ## Setup packages and mounts, then chroot hook for additional setup w/ chrootnset.shh
	printf " \n COMPLETE !  \n "
	printf " \n SHUT DOWN SYSTEM AND THEN \n"
	printf " \n REMOVE LIVE IMAGE \n "
	printf " \n AND REBOOT SYSTEM ! \n"
}

main
