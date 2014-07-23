#!/bin/bash
#
#
# 	Authors  ::->>  i3-Arch,  trewchainz, t60r  <<-::
#
#		Made to install archlinux
#
#		VERSION 1.3-BETA
#
############################################

# Grab var values
# Which are: yourdrive, rewtpart, swappart, homepart, bootpart, thechoiceman
source config.sh

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

# Set Your Hostname
hostname() {
	clear
	printf "\033[1m \n ${yellow}Choose your hostname: ${white} \033[0m"
	read hostresponse
	echo "$hostresponse" > /etc/hostname
}

# Set Time Zone
timelocale() {
	clear
	printf "\033[1m \n ${yellow}     Enter your Time Zone ${white}\n \033[0m"
	printf "\033[1m \n ${red}CHOICES ARE: ${white}New York ${green}or ${white}Athens \n \033[0m"
	printf "\033[1m \n ${yellow}Sorry I didnt do all timezones yet\n \n \033[0m"
	printf "\033[1m \n ${white}ENTER ${green}(1)${red}for New York \n \033[0m"
	printf "\033[1m${white}ENTER ${green}(2)${red}for Athens \n \033[0m"
	printf "\033[1m \n ${white} Choice: \033[0m"
	read timezoneresponse
	if [ "$timezoneresponse" == NewYork -o "$timezoneresponse" == 1 ]
		then
			$(ln -s /usr/share/zoneinfo/America/New_York /etc/localtime) ;
	elif	[ "$timezoneresponse" == Athens -o "$timezoneresponse" == 2 ]
		then
			$( ln -s /usr/share/zoneinfo/Europe/Athens /etc/localtime) ;
	else
		printf "\033[1m ${red}Not Understood | do it yourself |  with 'ln -s'\n\033[0m"
	fi
	clear
	printf "\033[1m \n\n${white}YOU NOW NEED TO UNCOMMENT A LOCALE\n \033[0m"
	printf "\033[1m \n${green}Would you like to use default locale or choose your own? \n\n \033[0m"
	printf "\033[1m ${white}Default locale is ${red}en_US.UTF-8 UTF-8 \n\n \033[0m"
	printf "\033[1m \n${yellow}(Y)${green} for default locale \n${yellow}(N) ${green}for choose your own \n \033[0m"
	printf "\033[1m \n ${white}Choice: \033[0m"
	read inputscuzlocale
	if [ "$inputscuzlocale" == y -o "$inputscuzlocale" == Y ]
		then
			echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		nano /etc/locale.gen
	fi
	printf "\033[1m ${green}NOW GENERATING LOCALES...\n \033[0m"
	locale-gen
}

# Install Grub
grubinst() {										
	grub-install --target=i386-pc $yourdrive
	grub-mkconfig -o /boot/grub/grub.cfg
}

# Install Syslinux
syslinuxinst() {
	pacman -Syy syslinux --noconfirm
	syslinux-install_update -i -a -m
	printf " \033[1m ${red} Edit APPEND root=/dev/sda3 to point to your / partition. ${white} \n \033[0m"
	echo -e "\033[1m ${green} Press Enter to Continue\033[0m"
	read Enter
	nano /mnt/boot/syslinux/syslinux.cfg   #Edited to have user edit the file to their needs
}

# Choose Your Bootloader
BOOTload() {
	printf "\033[1m \n ${white} CHOOSE YOUR BOOTLOADER \n \033[0m"
	printf "\033[1m \n ${white}(1)${red}For Grub \n \033[0m"
	printf "\033[1m \n ${white}(2)${red}For SysLinux \n \033[0m"
	printf "\033[1m \n ${yellow}CHOICE: ${white}\033[0m"
	read bootloadchoice
	if [ "$bootloadchoice" -eq 1 ]
		then
			grubinst
	elif [ "$bootloadchoice" -eq 2 ]
		then
			syslinuxinst
	else
		printf "\033[1m ${red}Not Understood ${white}|${red} Setting up grub by default \033[0m"
		grubinst
	fi
}	

# Main Function
main() {
	hostname
	timelocale
	BOOTload
	rm chrootnset.sh config.sh #cleanup
	wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/post-install.sh
	exit
}

main

#EOF
