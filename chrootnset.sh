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
source config.sh #grab rewtpart, swappart, homepart, bootpart, thechoiceman var values

#COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

decisions() {
	if [ $thechoiceman -eq 3 ]
		then
		    fstab3
		elif [ $thechoiceman -eq 2 ]
	 		then
		   	fstab2
		elif [ $thechoiceman -eq 1 ]
			then
	  	    	fstab1
		else
	    	    fstab1
	fi
}

fstab1() {
	printf " \033[1m \n ${red} Setting up fstab...\n \033[0m"
	echo " $rewtpart        /       ext4   defaults    0    1" >> /etc/fstab
	echo " $bootpart        /mnt/boot       ext4    defaults        0       1"      >> /etc/fstab
}

fstab2() {
        printf " \033[1m \n ${red} Setting up fstab...\n \033[0m"
     	echo " $rewtpart        /       ext4   defaults    0    1" >> /etc/fstab
     	echo " $homepart        /home   ext4    defaults        0        1" >> /etc/fstab
     	echo " $bootpart        /mnt/boot       ext4    defaults        0       1"      >> /etc/fstab
}

fstab3() {
	printf " \033[1m \n ${red} Setting up fstab...\n \033[0m"
	echo " $rewtpart	/    	ext4   defaults    0    1" >> /etc/fstab
	echo " $swappart	none     swap    defaults    0    1" >> /etc/fstab
	echo " $homepart	/home 	ext4	defaults	0	 1" >> /etc/fstab
	echo " $bootpart	/mnt/boot	ext4	defaults	0	1"	>> /etc/fstab
}

hostname() {
	printf "\033[1m \n ${yellow}Choose your hostname: ${white}\n \033[0m"
	read hostresponse
	echo "$hostresponse" > /etc/hostname
}

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
	printf " YOU NOW NEED TO UNCOMMENT A LOCALE\n"
	printf " Would you like to use default locale or choose your own? \n"
	printf " Default locale is en_US.UTF-8 UTF-8 \n"
	printf " \n(Y) for default locale \n(N) for choose your own \n "
	read inputscuzlocale
	if [ "$inputscuzlocale" == y -o "$inputscuzlocale" == Y ]
		then
			echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		nano /etc/locale.gen
	fi
	printf " NOW GENERATING LOCALES...\n"
	locale-gen
}

main() {
	decisions
	hostname
	timelocale
	mkinitcpio -p linux
	rm chrootnset.sh config.sh #cleanup
	exit
}

main
