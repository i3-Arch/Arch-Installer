#!/bin/bash
#
#
# 	Authors  ::->>     i3-Arch,  trewchainz, t60r    <<-::
#
#		Made to install archlinux
#
#		VERSION 1.2-BETA
#
#	WARNING : THIS SCRIPT IS CURRENTLY BEING DEVELOPED
#			RUN AT YOUR OWN RISK
#
#	Reminder  -  Add option for LUKS
############################################

# Grab var values
# Which are: yourdrive, rewtpart, swappart, homepart, bootpart, thechoiceman
source config.sh

# IF statement for swap | if it exists
#check4swap() {
#if [ $FULLpart -eq 696 ]
#	then
#		echo -n "13371337-0000-4000-0000-133700133700"   "none"   "swap"   "defaults"   "0"   "0" >> /etc/fstab
#fi
#}

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

# Set Your Hostname
hostname() {
	printf "\033[1m \n ${yellow}Choose your hostname: ${white}\n \033[0m"
	read hostresponse
	echo "$hostresponse" > /etc/hostname
}

# Set Time Zone
timelocale() {
	printf "\033[1m \n ${yellow}Enter your Time Zone: ${white}\n \033[0m"
	printf "\033[1m \n ${red}CHOICES ARE: ${white}New York ${green}or ${white}Athens \n \033[0m"
	printf "\033[1m \n ${yellow}Sorry I didnt do all timezones yet\n \n \033[0m"
	printf "\033[1m \n ${white}ENTER ${green}(1)${red}for New York \n \033[0m"
	printf "\033[1m    ${white}ENTER ${green}(2)${red}for Athens \n \033[0m"
	read timezoneresponse
	if [ "$timezoneresponse" == NewYork -o "$timezoneresponse" == 1 ]
		then
			$(ln -s /usr/share/zoneinfo/America/New_York /etc/localtime) ;
	elif	[ "$timezoneresponse" == Athens -o "$timezoneresponse" == 2 ]
		then
			$( ln -s /usr/share/zoneinfo/Europe/Athens /etc/localtime) ;
	else
		printf " Not Understood | skipped | do it yourself |  with 'ln -s'\n"
	fi
	printf "\033[1m ${white}YOU NOW NEED TO UNCOMMENT A LOCALE\n \033[0m"
	printf "\033[1m ${green}Would you like to use default locale or choose your own? \n \033[0m"
	printf "\033[1m ${white}Default locale is ${red}en_US.UTF-8 UTF-8 \n \033[0m"
	printf "\033[1m \n${yellow}(Y)${green} for default locale \n${yellow}(N) ${green}for choose your own \n \033[0m"
	read inputscuzlocale
	if [ "$inputscuzlocale" == y -o "$inputscuzlocale" == Y ]
		then
			echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		nano /etc/locale.gen
	fi
	printf "\033[1m NOW GENERATING LOCALES...\n \033[0m"
	locale-gen
}

# Install Grub
grubinst() {										
	grub-install --target=i386-pc $yourdrive
	grub-mkconfig -o /boot/grub/grub.cfg
}

# Install Syslinux
syslinuxinst() {
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
			grubinst
	fi
}	

# Main Function
main() {
	#check4swap
	hostname
	timelocale
	BOOTload
	rm chrootnset.sh config.sh #cleanup
	exit
}

main
