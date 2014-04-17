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
echo
echo " WELCOME TO i3 ARCHLINUX INSTALL SCRIPT "
echo
echo " Running lsblk to list block devices  "
echo
lsblk
echo " Which Drive would you like to install to "
echo " i.e - /dev/sda "
echo " WARNING : /dev/sda may not be empty for you "
read yourdrive
echo
echo " CREATE ::  boot - root -  home  - swap  partitions "
echo " Would you like to use cfdisk or fdisk ? "
echo
read toolchoice
if [ "$toolchoice" == "cfdisk" -o "$toolchoice" == "CFDISK" ]
	then
cfdisk $yourdrive
	else
fdisk $youdrive
fi
echo
echo " ENTER YOUR BOOT PARTITION"
read bootpart
mkfs.ext4 "$bootpart" -L bootfs
echo
echo " Enter Your Root Partition " 
echo " i.e  /dev/sda1  "
echo
read rewtpart
mkfs.ext4 "$rewtpart" -L rootfs
echo 
echo " Enter Your Home Partition"
echo
read homepart
mkfs.ext4 "$homepart"
echo
echo " What is your swap partition"
echo
read swappart
mkswap "$swappart" -L swapfs
echo
echo " Setting up install "
	$(mount $rewtpart /mnt) ;
	$(mkdir -pv /mnt/var/lib/pacman) ;
	$(pacman -r /mnt -Sy base base-devel) ;
	$(rsync -rav /etc/pacman.d/gnupg/ /mnt/etc/pacman.d/gnupg/) ;
	$(mount --bind /dev/ /mnt/dev) ;
	$(mount --bind /sys/ /mnt/sys) ;
	$(mount --bind /proc/ /mnt/proc) ;
	$(chroot /mnt /bin/bash) ;
echo
echo " Setting up fstab"
echo
echo " $rewtpart    /    	ext4   defaults    0    1" >> /etc/fstab
echo " $swappart    none     swap    defaults    0    1" >> /etc/fstab
echo " $homepart    /home 	ext4	defaults	0	 1" >> /etc/fstab
echo " $bootpart	/boot	ext4	defaults	0	1"	>> /etc/fstab
echo " Choose your hostname"
read hostresponse
echo "$hostresponse" > /etc/hostname
echo " Enter Your Time Zone "
echo
echo " CHOICES ARE  ' New York or Athens ' "
echo
echo " Sorry I didnt do all timezones yet "
read timezoneresponse
if [ $timezoneresponse -eq "New York" -o $timezoneresponse -eq "new york" -o $timezoneresponse -eq "NEW YORK" -o $timezoneresponse -eq " newyork " ] 
	then
		$(ln -s /usr/share/zoneinfo/America/New_York /etc/localtime) ;
	elif	[ $timezoneresponse -eq "Athens" -o $timezoneresponse -eq "athens" -o $timezoneresponse -eq "ATHENS" ]
		then
			$( ln -s /usr/share/zoneinfo/Europe/Athens /etc/localtime) ;
	else
		echo " Not Understood | skipped | do it yourself |  with 'ln -s' "
fi
echo
echo " YOU NOW NEED TO UNCOMMENT LOCALE "
sleep 2
vim /etc/local.gen
echo
echo " NOW GENERATING LOCALES"
$(locale-gen) ;
$(mkinitcpio -p linux) ;
exit
$(grub-install --boot-directory=/mnt/boot $bootpart) ;
$(grub-mkconfig -o /mnt/boot/grub/grub.cfg) ;
echo "menuentry"\ "Archlinux"\ "{" >> /mnt/boot/grub/grub.cfg
echo "    set root=(hd0,1) " >> /mnt/boot/grub/grub.cfg
echo " linux /boot/vmlinuz-linux root=$rewtpart " >> /mnt/boot/grub/grub.cfg
echo " initrd /boot/initramfs-linux.img " >> /mnt/boot/grub/grub.cfg
echo "	} "
