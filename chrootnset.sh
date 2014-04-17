#!/bin/bash
#
#
# 	BY : i3-Arch
#					
#		Made to install archlinux
#		
#		VERSION 1.0-BETA
#	
#	WARNING : THIS SCRIPT IS CURRENTLY BEING DEVELOPED
#			RUN AT YOUR OWN RISK
#
#	Reminder  -  Add option for LUKS
############################################

printf " Setting up fstab\n"
echo " $REWTPART    /    	ext4   defaults    0    1" >> /etc/fstab; printf "\n"
echo " $SWAPPART    none     swap    defaults    0    1" >> /etc/fstab; printf "\n"
echo " $HOMEPART    /home 	ext4	defaults	0	 1" >> /etc/fstab; printf "\n"
echo " $BOOTPART	/boot	ext4	defaults	0	1"	>> /etc/fstab; printf "\n"
printf " Choose your hostname:\n"
read hostresponse
echo "$hostresponse" > /etc/hostname; printf "\n"
printf " Enter Your Time Zone:\n"
printf " CHOICES ARE  ' New York or Athens '\n"
printf " Sorry I didnt do all timezones yet\n"
read timezoneresponse
if [ $timezoneresponse -eq "New York" -o $timezoneresponse -eq "new york" -o $timezoneresponse -eq "NEW YORK" -o $timezoneresponse -eq " newyork " ] 
	then
		$(ln -s /usr/share/zoneinfo/America/New_York /etc/localtime) ;
	elif	[ $timezoneresponse -eq "Athens" -o $timezoneresponse -eq "athens" -o $timezoneresponse -eq "ATHENS" ]
		then
			$( ln -s /usr/share/zoneinfo/Europe/Athens /etc/localtime) ;
	else
		printf " Not Understood | skipped | do it yourself |  with 'ln -s'\n"
fi
printf " YOU NOW NEED TO UNCOMMENT LOCALE\n"
sleep 2
touch /etc/local.gen
printf " NOW GENERATING LOCALES\n"
locale-gen 
mkinitcpio -p linux
grub-install --boot-directory=/mnt/boot $BOOTPART
grub-mkconfig -o /mnt/boot/grub/grub.cfg
echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg; printf "\n"
echo "    set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo " linux /boot/vmlinuz-linux root=$REWTPART " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo "	}"

#cleanup
printf " Cleaning up...\n"
sleep 10
rm chrootnset.sh
