#!/bin/bash
#
# 	Authors ::->>	 i3-Arch, trewchainz, t60r  <<-::
#
#		Made to install archlinux
############################################

#Version
Version="2.0-BETA"

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
		printf "\033[1m\n      ${white}#${green}Archlinux${white}-${green}Swag\n\033[0m"
		sed -i '37iILoveCandy' /etc/pacman.conf
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
	printf "		########################################\n"
	printf "		##   Installer Version:  "$Version"     ##\n"
	printf "		########################################\n\n"
	sleep 3
}

disk() {
	clear
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
    	if [ "$encRyesno" == N -o "$encRyesno" == n ]
		then
		mkfs.ext4 "$rewtpart" -L rootfs
	fi
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
        if [ "$encRyesno" == N -o "$encRyesno" == n ]
		then
		mkfs.ext4 "$rewtpart" -L rootfs
	fi
	printf " \033[1m \n ${white}Enter your Home Partition: ${red}i.e. /dev/sda3 \n \033[0m"
    	printf " \033[1m \n ${yellow}Home Partition: ${white} \033[0m"
	read homepart
        echo "homepart=$homepart" >> config.sh
        if [ "$encHyesno" == N -o "$encHyesno" == n ]
		then
		mkfs.ext4 "$homepart"
	fi
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
   	if [ "$encRyesno" == N -o "$encRyesno" == n ]
		then
		mkfs.ext4 "$rewtpart" -L rootfs
	fi	
	printf " \033[1m \n ${white}Enter your Home Partition: ${red}i.e. /dev/sda3 \n \033[0m"
	printf "\033[1m \n ${yellow}Home Partition: ${white}\033[0m"
	read homepart
	echo "homepart=$homepart" >> config.sh
   	if [ "$encHyesno" == N -o "$encHyesno" == n ]
		then
		mkfs.ext4 "$homepart"
	fi	
	printf "\033[1m \n ${white}Enter your Swap Partition: ${red}i.e. /dev/sda5 \n \033[0m"
	printf "\033[0m \n ${yellow}Swap Partition: ${white}\033[0m"
	read swappart
	echo "swappart=$swappart" >> config.sh
	mkswap -U 13371337-0000-4000-0000-133700133700 $swappart
	swapon $swappart
	echo "FULLpart=696" >> config.sh
}

doiencrypt() {
	clear
	printf " \033[1m ${green} Encrypt Root? \n \033[0m"
	printf " \033[1m ${yellow} [Y/N]: \033[0m"
	read encRyesno
	echo "encRyesno=$encRyesno" >> config.sh
	if [ "$encRyesno" == Y -o "$encRyesno" == y ]
		then
		printf "\n\n Root will be encrypted! \n"
	elif [ "$encRyesno" == N -o "$encRyesno" == n ]
		then
		printf "\n\n Not Encrypting: Moving on \n"
	else
		printf "\n\n Not Encrypting: 'Y' or 'N' not entered \n\n"
	fi
	if [ "$thechoiceman" -eq 2 -o "$thechoiceman" -eq 3 ]
		then
		printf "\033[1m ${green} Encrypt Home? \n \033[0m"
		printf "\033[1m ${yellow} [Y/N]: \033[0m"
		read encHyesno
		echo "encHyesno=$encHyesno" >> config.sh
		if [ "$encHyesno" == Y -o "$encHyesno" == y ]
			then
			printf "\n\n Home will be encrypted! \n"
		elif [ "$encHyesno" == N -o "$encHyesno" == n ]
			then
			printf "\n Not Encrypting: Moving on\n\n"
		else
			printf "\n Not encrypting: 'Y' or 'N' not entered \n\n"
		fi
	fi
	if [ "$thechoiceman" -eq 3 ]
		then
		printf "\033[1m ${green} Encrypt Swap? \n \033[0m"
		printf "\033[1m ${yellow} [Y/N]: \033[0m"
		read encSyesno
		echo "encSyesno=$encSyesno" >> config.sh
		if [ "$encSyesno" == Y -o "$encSyesno" == y ]
			then
			printf "\033[1m ${green} Swap will be encrypted! \n \033[0m"
		elif [ "$encSyesno" == N -o "$encSyesno" == n ]
			then
			printf "\n Not Encrypting: Moving on \n\n"
		else
			printf "\n Not Encrypting: 'Y' or 'N' not entered \n\n"
		fi
	fi
}


luksencrypt() {
	if [ "$encRyesno" == Y -o "$encRyesno" == y ]
		then
		cryptsetup -y -v -s 512 luksFormat $rewtpart
		cryptsetup open $rewtpart cryptrewt
		mkfs -t ext4 /dev/mapper/cryptrewt
	fi
	if [ "$encHyesno" == Y -o "$encHyesno" == y ]
		then
		cryptsetup -y -v -s 512 luksFormat $homepart
		cryptsetup open $homepart crypthome
		mkfs -t ext4 /dev/mapper/crypthome
	fi
}

pkgmntchroot() {
	clear
	printf " \033[1m ${green} Setting up install... ${white}\n\033[0m "
	if [ "$encRyesno" == Y -o "$encRyesno" == y ]
		then
		mount -t ext4 /dev/mapper/cryptrewt /mnt
	else
		mount $rewtpart /mnt
	fi
	mkdir /mnt/home
	mkdir /mnt/boot
	mkdir -pv /mnt/var/lib/pacman
	mount $bootpart /mnt/boot
	if [ "$encHyesno" == Y -o "$encHyesno" == y ]
		then
		mount -t ext4 /dev/mapper/crypthome /mnt/home
	fi
	if [ "$thechoiceman" -eq 2 -o "$thechoiceman" -eq 3 ]
		then
		if [ "$encHyesno" != Y -o "$encHyesno" != y ]
			then
			mount $homepart /mnt/home
		fi
	fi
	printf "\033[1m ${green} Intel or AMD CPU \n \033[0m"
	printf "\033[1m ${yellow} Y for INTEL, N for AMD: \033[0m"
	read intelamd
	if [ "$intelamd" == Y -o "$intelamd" == y ]
		then
		printf "\033[1m ${green} You selected INTEL \033[0m"
		pacstrap /mnt base base-devel grub os-prober rsync wget wpa_supplicant linux linux-firmware intel-ucode
	elif [ "$intelamd" == N -o "$intelamd" == n ]
		then
		printf "\033[1m ${green} You selected AMD \033[0m"
		pacstrap /mnt base base-devel grub os-prober rsync wget wpa_supplicant linux linux-firmware amd-ucode
	else
		printf "\033[1m ${green} Assuming you want AMD... proceeding \033[0m \n"
		pacstrap /mnt base base-devel grub os-prober rsync wget wpa_supplicant linux linux-firmware amd-ucode
	fi
	rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/
	if [ "$encRyesno" == Y -o "$encRyesno" == y ]
	   then
	   sed -i 's/block filesystems/block keymap encrypt filesystems/g' /mnt/etc/mkinitcpio.conf
	fi
	genfstab -p -U /mnt >> /mnt/etc/fstab
	printf "\033[1m ${green} Enter root password \033[0m \n"
	passwd
	wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/chrootnset.sh
	chmod +x chrootnset.sh
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
	    printf "\033[1m ${red}\n\nUnkown Selection\n\n\033[0m"
	    printf "\033[1m ${white}\n\Only Setting up ${yellow}BOOT ${white}and ${yellow}ROOT\n\033[0m"
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
	if [ -f post-menu.sh ]
		then
		cp post-menu.sh /mnt/root
	else
		wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/post-menu.sh
		cp post-menu.sh /mnt/root
	fi
	if [ -f another.sh ]
		then
		cp another.sh /mnt/root
	else
		wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/another.sh
		cp another.sh /mnt/root
	fi
	if [ -f wireless-setup.sh ]
		then
		cp wireless-setup.sh /mnt/root
		
	else
		wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/wireless-setup.sh
		cp wireless-setup.sh /mnt/root
	fi
	if [ -f wired-setup.sh ]
		then
		cp wired-setup.sh /mnt/root
	else
		wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/wired-setup.sh
		cp wired-setup.sh /mnt/root
	fi
}


sixfour() {
	if [ "$(uname -m)" = x86_64 ]
		then
		sed -i'' '93,94 s/^#//' /mnt/etc/pacman.conf
	fi
}

candy() { 
	clear
	printf "\033[1m \n\n ${green} Would you like to see \n\033[0m"
	printf "\033[1m ${green}pacman when updating/upgrading? \n\033[0m"
	printf "\033[1m ${yellow}[----cC o  o ]${green} instead of${yellow} [########] \n\n\033[0m"
	printf "\033[1m ${white}	[Y/N] \n\033[0m"
	printf "\033[1m \n\n\n ${red}L${white}o${red}v${white}e ${green}Candy${red}?${white}:\033[0m"
	read lovecandy
	if [ "$lovecandy" == Y -o "$lovecandy" == y ]
		then
		sed -i '37iILoveCandy' /mnt/etc/pacman.conf
	fi
}

main() {
	checkdat			## Check if ROOT
	banner				## Banner
	touch config.sh 		## Create file to store bootpart, rewtpart, homepart, swappart for chroot
	ASKme				## ASK NUMBER OF PARTITIONS
	doiencrypt			## Do I Encrypt?
	disk 				## PARTITION WITH CFDISK or FDISK
	CALLpart 	 		## CALL PARTITIONING IF STATEMENT
	luksencrypt			## Setup LUKS
	pkgmntchroot 	 		## Setup packages and mounts, then chroot hook for additional setup w/ chrootnset.shh
	sixfour				## If 64bit uncomment multilib
	cp issue /mnt/etc/issue   	## TTY ART 
	candy				## Choose if you want pacman art when updating
	postsetup			## POST INSTALL SCRIPT READY FOR AFTER INSTALL
	umount -R /mnt	2> /dev/null	## UNMOUNT 
	clear
	printf "\033[1m \n ${green} COMPLETE !  \n \033[0m"
	printf "\033[1m \n ${yellow} SHUT DOWN SYSTEM AND THEN \n \033[0m"
	printf "\033[1m \n ${yellow} REMOVE LIVE IMAGE \n \033[0m"
	printf "\033[1m \n ${red} THEN BOOT SYSTEM ! \n \033[0m"
}

main

# EOF
