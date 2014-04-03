#!/bin/bash
#
#
# 	BY : i3-Arch
#					
#		Made to install archlinux
#		And setup my custom i3 setup
#		
#	Reminder  -  Add option for LUKS
############################################
echo
echo " \n \n \n WELCOME TO i3 ARCHLINUX INSTALL SCRIPT \n"
echo
echo " Running lsblk to list block devices \n "
echo
lsblk
echo " Which Drive would you like to install to \n "
echo " i.e - /dev/sda \n "
echo " WARNING : /dev/sda may not be empty for you \n"
read yourdrive
echo
echo " CREATE ::  root -  home  - swap  partitions \n "
echo " Would you like to use cfdisk or fdisk ? \n "
echo
read toolchoice
if [ "$toolchoice" -eq cfdisk ]
	then
		$(cfdisk "$yourdrive")
	else
		$(fdisk "$youdrive")
fi
echo
echo " Enter Your Root Partition \n " 
echo " i.e  /dev/sda1 \n "
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
