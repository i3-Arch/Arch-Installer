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
echo " $rewtpart    /    	ext4   defaults    0    1" >> /etc/fstab
echo " $swappart    none     swap    defaults    0    1" >> /etc/fstab
echo " $homepart    /home 	ext4	defaults	0	 1" >> /etc/fstab
echo " $bootpart	/boot	ext4	defaults	0	1"	>> /etc/fstab
printf " Choose your hostname:\n"
read hostresponse
echo "$hostresponse" > /etc/hostname
printf " \n Enter Your Time Zone:\n"
printf " \n CHOICES ARE  ' New York or Athens ' \n"
printf " \n Sorry I didnt do all timezones yet \n"
printf " \n Enter (1) for New York  \n "
printf " \n Enter (2) for Athens \n "
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
printf " Would you like to use default locale or choose your own ? \n"
printf " Default locale is en_US.UTF-8 UTF-8 \n"
printf " (Y) for default locale \n  (N) for choose your own \n "
read inputscuzlocale
if [ "$inputscuzlocale" == y -o "$inputscuzlocale" == Y ]
	then
		echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		nano /etc/locale.gen
fi
printf " NOW GENERATING LOCALES\n"
locale-gen 
mkinitcpio -p linux
$(grub-install --boot-directory='/mnt $yourdrive')
$(grub-mkconfig -o /mnt /boot/grub/grub.cfg)
echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg
echo "    set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg
echo " linux /boot/vmlinuz-linux root=$rewtpart " >> /mnt/boot/grub/grub.cfg
echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg
echo "	}" >> /mnt/boot/grub/grub.cfg

#cleanup
printf " Cleaning up...\n"
sleep 10
rm chrootnset.sh config.sh
printf " \n NOW SHUTTING DOWN \n "
printf " \n REMOVE LIVE IMAGE \n "
printf " \n THEN REBOOT SYSTEM ! \n"
sleep 3
sdn="$(shutdown now)"
$sdn
