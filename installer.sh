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
echo " WELCOME TO i3 ARCHLINUX INSTALL SCRIPT "
echo
echo " Running lsblk to list block devices "
echo
lsblk
echo " Which Drive would you like to install to "
echo " i.e - /dev/sda "
echo " WARNING : /dev/sda may not be empty for you"
read yourdrive
echo
echo " Would you like to use cfdisk or fdisk ? "
echo
read toolchoice
if [ $toolchoice -eq cfdisk ]
	then
		$(cfdisk $yourdrive)
	else
		$(fdisk $youdrive)
fi
