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
printf " WELCOME TO i3 ARCHLINUX INSTALL SCRIPT\n"
printf " Running lsblk to list block devices\n"
lsblk
printf " Which Drive would you like to install to\n"
printf " i.e - /dev/sda\n"
printf " WARNING : /dev/sda may not be empty for you\n"
read yourdrive
printf " CREATE ::  boot - root -  home  - swap  partitions\n"
printf " Would you like to use cfdisk or fdisk ?\n"
read toolchoice
if [ "$toolchoice" == cfdisk -o "$toolchoice" == CFDISK ]
	then
cfdisk $yourdrive
	else
fdisk $yourdrive
fi
printf " Enter Your Boot Partition:\n"
read bootpart
mkfs.ext4 "$bootpart" -L bootfs
printf " Enter Your Root Partition:\n" 
printf " i.e  /dev/sda1\n"
read rewtpart
mkfs.ext4 "$rewtpart" -L rootfs
printf " Enter Your Home Partition:\n"
read homepart
mkfs.ext4 "$homepart"
printf " What is your swap partition:\n"
read swappart
mkswap "$swappart" -L swapfs
printf " Setting up install\n"
	$(mount $rewtpart /mnt)
	$(mkdir -pv /mnt/var/lib/pacman)
	$(pacman -r /mnt -Sy base base-devel)
	$(rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/)
	$(mount --bind /dev/ /mnt/dev)
	$(mount --bind /sys/ /mnt/sys)
	$(mount --bind /proc/ /mnt/proc)
	$(chroot /mnt /bin/bash)
printf " Setting up fstab\n"
echo " $rewtpart    /    	ext4   defaults    0    1" >> /etc/fstab; printf "\n"
echo " $swappart    none     swap    defaults    0    1" >> /etc/fstab; printf "\n"
echo " $homepart    /home 	ext4	defaults	0	 1" >> /etc/fstab; printf "\n"
echo " $bootpart	/boot	ext4	defaults	0	1"	>> /etc/fstab; printf "\n"
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
vim /etc/local.gen
printf " NOW GENERATING LOCALES\n"
$(locale-gen) ;
$(mkinitcpio -p linux) ;
exit
$(grub-install --boot-directory=/mnt/boot $bootpart) ;
$(grub-mkconfig -o /mnt/boot/grub/grub.cfg) ;
echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg; printf "\n"
echo "    set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo " linux /boot/vmlinuz-linux root=$rewtpart " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg; printf "\n"
echo "	}"
$(reboot) ;
