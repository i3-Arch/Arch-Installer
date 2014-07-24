#!/bin/bash
#
# 	Authors ::->>	 i3-Arch, trewchainz, t60r  <<-::
#
#		Made to install archlinux
#
#		VERSION 1.3-BETA
#
############################################

# FONT
setfont Lat2-Terminus16

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

checkdat() {
	if [ "$(id -u)" -eq 0 ]	
		then
		printf "\033[1m ${green} \n#Archlinux-Swag\n\033[0m"
		sleep 2
	else
		printf "\033[1m ${red} You Need To Be ROOT \n\033[0m"
		printf "\033[1m ${yellow} You really need to look at the ReadMe on github \033[0m"
		exit
	fi
}


banner() {
	clear
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
	clear
	printf " \033[1m ${red}\n  * REMINDER * ${white}\n\n IF PLANNING TO USE SYSLINUX \n \033[0m"
	printf " \033[1m ${white}MAKE SURE BOOT PARTITION IS ${green}/dev/sda1 \n\n\n \033[0m"
	printf " \033[1m ${red} Listing Block Devices \n\n \033[0m"
	lsblk |grep -v "loop*" |grep -v "arch_root*"
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
	clear
	printf "\033[1m \n${green}       CHOICES \n\n\n\033[0m"
	printf " \033[1m  ${red}(1)${white}boot and root partitions \n \033[0m"
	printf " \033[1m ${red}(2)${white}boot, root, home partitions \n \033[0m "
	printf " \033[1m${red}(3)${white}boot, root, home, swap partitions \n \n \033[0m"
	printf " \033[1m ${white}\n SELECT \n\n${red}       1 ${red}2 ${white}or${red} 3 \n\n \033[0m"
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
	mkswap -U 13371337-0000-4000-0000-133700133700 $swappart
	swapon $swappart
	echo "FULLpart=696" >> config.sh
}

pkgmntchroot() {
	clear
	printf " \033[1m ${green} Setting up install... ${white} \n \033[0m "
	mount $rewtpart /mnt
	mkdir /mnt/home
	mkdir /mnt/boot
	mkdir -pv /mnt/var/lib/pacman
	mount $bootpart /mnt/boot
	mount $homepart /mnt/home
	pacstrap /mnt base base-devel grub os-prober rsync wget
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	genfstab -p -U /mnt >> /mnt/etc/fstab
	cp chrootnset.sh config.sh /mnt
	arch-chroot /mnt /bin/bash chrootnset.sh
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
	    printf "\033[1m ${red}Unkown Selection\n\n\033[0m"
	    printf "\033[1m ${white}Only Setting up ${yellow}BOOT ${white}and ${yellow}ROOT\033[0m"
	    sleep 3
	    SMALLpart
	fi
}


postsetup() {
	if [ -f post-install.sh	]
		then
		cp post-install.sh /mnt/root
	else
		wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/post-install.sh
		cp post-install.sh /mnt/root
	fi
}


main() {
	checkdat
	banner
	touch config.sh 		## Create file to store bootpart, rewtpart, homepart, swappart for chroot
	ASKme				## ASK NUMBER OF PARTITIONS
	disk 				## PARTITION WITH CFDISK or FDISK
    	CALLpart 	 		## CALL PARTITIONING IF STATEMENT
	pkgmntchroot 	 		## Setup packages and mounts, then chroot hook for additional setup w/ chrootnset.shh
	cp issue /mnt/etc/issue   	## TTY ART 
	postsetup			## POST INSTALL SCRIPT READY FOR AFTER INSTALL
	umount -R /mnt			## UNMOUNT 
	clear
	printf "\033[1m \n ${green} COMPLETE !  \n \033[0m"
	printf "\033[1m \n ${yellow} SHUT DOWN SYSTEM AND THEN \n \033[0m"
	printf "\033[1m \n ${yellow} REMOVE LIVE IMAGE \n \033[0m"
	printf "\033[1m \n ${red} THEN BOOT SYSTEM ! \n \033[0m"
}

main

# EOF
