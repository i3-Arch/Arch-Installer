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
source config.sh #grab rewtpart, swappart, homepart, bootpart var values
nicetty () {
	wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/issue
	cp issue /etc/issue
	rm issue
}

decisions () {
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

fstab1 () {
	printf " Setting up fstab...\n"
	echo " $rewtpart        /       ext4   defaults    0    1" >> /etc/fstab
	echo " $bootpart        /mnt/boot       ext4    defaults        0       1"      >> /etc/fstab
}

fstab2 () {
        printf " Setting up fstab...\n"
     	echo " $rewtpart        /       ext4   defaults    0    1" >> /etc/fstab
     	echo " $homepart        /home   ext4    defaults        0        1" >> /etc/fstab
     	echo " $bootpart        /mnt/boot       ext4    defaults        0       1"      >> /etc/fstab
}

fstab3 () {
	printf " Setting up fstab...\n"
	echo " $rewtpart	/    	ext4   defaults    0    1" >> /etc/fstab
	echo " $swappart	none     swap    defaults    0    1" >> /etc/fstab
	echo " $homepart	/home 	ext4	defaults	0	 1" >> /etc/fstab
	echo " $bootpart	/mnt/boot	ext4	defaults	0	1"	>> /etc/fstab
}

hostname () {
	printf " Choose your hostname:\n"
	read hostresponse
	echo "$hostresponse" > /etc/hostname
}

timelocale () {
	printf " \n Enter your Time Zone:\n"
	printf " CHOICES ARE: New York or Athens \n"
	printf "  Sorry I didnt do all timezones yet\n"
	printf " \n Enter (1) for New York \n "
	printf "  Enter (2) for Athens \n "
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

main () {
	nicetty
	decisions
	hostname
	timelocale
	mkinitcpio -p linux
	rm chrootnset.sh config.sh #cleanup
	exit
}

main
