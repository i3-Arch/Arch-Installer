#!/bin/bash
#
#
# 	Authors  ::->>     i3-Arch,  trewchainz, t60r    <<-::
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
source config.sh #grab rewtpart, swappart, homepart, bootpart var values
printf " Setting up fstab\n"
echo " $rewtpart    /    	ext4   defaults    0    1" >> /etc/fstab; printf "\n"
echo " $swappart    none     swap    defaults    0    1" >> /etc/fstab; printf "\n"
echo " $homepart    /home 	ext4	defaults	0	 1" >> /etc/fstab; printf "\n"
echo " $bootpart	/boot	ext4	defaults	0	1"	>> /etc/fstab; printf "\n"
printf " Choose your hostname:\n"
read hostresponse
echo "$hostresponse" > /etc/hostname; printf "\n"
printf " Enter Your Time Zone:\n"
printf " CHOICES ARE  ' New York or Athens ' \n"
printf " Sorry I didnt do all timezones yet \n"
printf " Enter  1    for New York  :    Enter 2 for Athens"
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
printf " YOU NOW NEED TO UNCOMMENT LOCALE\n"
sleep 2
printf " Would you like to use default locale or choose your own ? \n"
printf " Default locale is en_US.UTF-8 UTF-8 \n"
printf " (Y) for default locale  (N) for choose your own"
read inputscuzlocale
if [ "$inputscuzlocale" -eq == y -o "$inputscuzlocale" == Y ]
	then
		echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	elif [ "$inputscuzlocale" == n -o "$inputscuzlocale" == N  ]
		nano /etc/locale.gen
	else
		echo "not understood"
fi
printf " NOW GENERATING LOCALES\n"
locale-gen 
mkinitcpio -p linux
grub-install --boot-directory=$yourdrive
grub-mkconfig -o /mnt/boot/grub/grub.cfg
echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg
echo "    set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg
echo " linux /boot/vmlinuz-linux root=$rewtpart " >> /mnt/boot/grub/grub.cfg
echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg
echo "	}" >> /mnt/boot/grub/grub.cfg

#cleanup
printf " Cleaning up...\n"
sleep 10
rm chrootnset.su
